import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../content/portfolio_content.dart';
import '../design/theme.dart';
import 'brand_widgets.dart';

class ProjectGallery extends StatefulWidget {
  const ProjectGallery({
    super.key,
    required this.project,
    required this.arabic,
  });
  final Project project;
  final bool arabic;
  @override
  State<ProjectGallery> createState() => _ProjectGalleryState();
}

class _ProjectGalleryState extends State<ProjectGallery> {
  final pages = PageController();
  int index = 0;
  @override
  void dispose() {
    pages.dispose();
    super.dispose();
  }

  void move(int next) => pages.animateToPage(
    next,
    duration: MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 240),
    curve: Curves.easeOut,
  );

  void enlarge(String asset) => showDialog<void>(
    context: context,
    builder: (context) => Dialog.fullscreen(
      child: Scaffold(
        backgroundColor: Brand.ink,
        appBar: AppBar(
          backgroundColor: Brand.ink,
          foregroundColor: Brand.white,
          title: Text(widget.project.name),
          leading: IconButton(
            tooltip: Copy.close.inLanguage(widget.arabic),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ),
        body: Center(
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Text(
                Copy.imageFailed.inLanguage(widget.arabic),
                style: const TextStyle(color: Brand.white),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final media = widget.project.images;
    if (media.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 370,
            child: PageView.builder(
              controller: pages,
              itemCount: media.length,
              onPageChanged: (value) => setState(() => index = value),
              itemBuilder: (_, i) => media[i].endsWith('.mp4')
                  ? ProjectVideo(
                      asset: media[i],
                      arabic: widget.arabic,
                      active: i == index,
                    )
                  : InkWell(
                      onTap: () => enlarge(media[i]),
                      child: Tooltip(
                        message: Copy.enlarge.inLanguage(widget.arabic),
                        child: ProjectImage(
                          asset: media[i],
                          label: '${widget.project.name} ${i + 1}',
                          arabic: widget.arabic,
                          height: 370,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: Copy.previous.inLanguage(widget.arabic),
              onPressed: index > 0 ? () => move(index - 1) : null,
              icon: const Icon(Icons.arrow_back),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${index + 1} / ${media.length}',
                textDirection: TextDirection.ltr,
              ),
            ),
            IconButton(
              tooltip: Copy.next.inLanguage(widget.arabic),
              onPressed: index < media.length - 1
                  ? () => move(index + 1)
                  : null,
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: media.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, i) => Semantics(
              selected: index == i,
              button: true,
              label: '${widget.project.name} ${i + 1}',
              child: Material(
                color: index == i ? Brand.accent : Brand.mist,
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => move(i),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: SizedBox(
                      width: 62,
                      child: media[i].endsWith('.mp4')
                          ? const Icon(Icons.play_circle_outline)
                          : Image.asset(
                              media[i],
                              fit: BoxFit.contain,
                              cacheWidth: 160,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.image_not_supported_outlined,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectVideo extends StatefulWidget {
  const ProjectVideo({
    super.key,
    required this.asset,
    required this.arabic,
    required this.active,
  });
  final String asset;
  final bool arabic;
  final bool active;
  @override
  State<ProjectVideo> createState() => _ProjectVideoState();
}

class _ProjectVideoState extends State<ProjectVideo>
    with WidgetsBindingObserver {
  VideoPlayerController? controller;
  bool loading = false;
  bool failed = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant ProjectVideo old) {
    super.didUpdateWidget(old);
    if (!widget.active) controller?.pause();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) controller?.pause();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  Future<void> start() async {
    setState(() => loading = true);
    final video = VideoPlayerController.asset(widget.asset);
    controller = video;
    try {
      await video.initialize();
      if (!mounted) return;
      setState(() => loading = false);
      final lifecycle = WidgetsBinding.instance.lifecycleState;
      if (widget.active &&
          (lifecycle == null || lifecycle == AppLifecycleState.resumed)) {
        await video.play();
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          loading = false;
          failed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Brand.ink,
    child: Center(
      child: failed
          ? Text(
              Copy.videoFailed.inLanguage(widget.arabic),
              style: const TextStyle(color: Brand.white),
            )
          : loading
          ? const CircularProgressIndicator()
          : controller == null
          ? FilledButton.icon(
              onPressed: start,
              icon: const Icon(Icons.play_arrow),
              label: Text(Copy.play.inLanguage(widget.arabic)),
            )
          : Column(
              children: [
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: VideoPlayer(controller!),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller!,
                  builder: (_, value, _) => IconButton(
                    color: Brand.white,
                    tooltip: (value.isPlaying ? Copy.pause : Copy.play)
                        .inLanguage(widget.arabic),
                    onPressed: () => value.isPlaying
                        ? controller!.pause()
                        : controller!.play(),
                    icon: Icon(
                      value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            ),
    ),
  );
}

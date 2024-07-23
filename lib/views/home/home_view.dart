import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../controllers/views_controller.dart';
import '../../res/responsive.dart';
import '../intro/components/side_menu_button.dart';
import '../intro/introduction.dart';
import '../information/information_view.dart';
import 'components/connect_button.dart';
import 'components/drawer/drawer.dart';
import 'components/navigation_button_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const List<Widget> pages = [
    Introduction(),
    InformationSectionView(
      title: 'Projects',
      index: 1,
      color: Colors.blue,
    ),
    InformationSectionView(
      title: 'Certifications',
      index: 2,
      color: Colors.transparent,
    ),
  ];
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        body: Consumer<ViewsController>(builder: (context, state, child) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(
                    AppBar().preferredSize.width,
                    AppBar().preferredSize.height *
                        (Responsive.isMobile(context) ? 2 : 1.5)),
                child: AppBar(
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    leading: MenuButton(
                      onTap: () => scaffoldKey.currentState!.openDrawer(),
                    ),
                    title: (!Responsive.isMobile(context))
                        ? const NavigationButtonList()
                        : const SizedBox(),
                    actions: const [
                      // ConstrainedBox(
                      //   constraints: BoxConstraints(
                      //       maxHeight:
                      //           MediaQuery.of(context).size.height * 0.05,
                      //       maxWidth: MediaQuery.of(context).size.width * 0.1),
                      //   child: Switch(
                      //     activeColor: Colors.amber,
                      //     thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                      //         (Set<WidgetState> states) {
                      //       if (states.contains(WidgetState.selected)) {
                      //         return const Icon(Icons.dark_mode);
                      //       }
                      //       return null;
                      //     }),
                      //     value: context.watch<ThemeController>().themeMode ==
                      //         ThemeMode.dark,
                      //     onChanged: (value) =>
                      //         context.read<ThemeController>().toggleTheme(),
                      //   ),
                      // )
                      ConnectButton(),
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size(AppBar().preferredSize.width,
                          AppBar().preferredSize.height * 2),
                      child: (Responsive.isMobile(context))
                          ? const NavigationButtonList()
                          : const SizedBox(),
                    )),
              ),
              body: LayoutBuilder(
                builder: (context, box) {
                  return ScrollablePositionedList.builder(
                    itemScrollController: state.itemScrollController,
                    itemBuilder: (context, index) => SizedBox(
                      width: box.maxWidth,
                      height: box.maxHeight,
                      child: pages[index],
                    ),
                    itemCount: pages.length,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

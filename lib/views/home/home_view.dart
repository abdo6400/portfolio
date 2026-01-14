import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../controllers/views_controller.dart';
import '../../res/responsive.dart';
import '../intro/introduction.dart';
import '../information/information_view.dart';
import 'components/connect_button.dart';
import 'components/drawer/drawer.dart';
import 'components/navigation_button_list.dart';
import 'components/theme_toggle_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const List<Widget> pages = [
    Introduction(),
    InformationSectionView(
      title: 'Projects',
      index: 1,
      contentType: 'projects',
    ),
    InformationSectionView(
      title: 'Skills',
      index: 2,
      contentType: 'skills',
    ),
    InformationSectionView(
      title: 'Certifications',
      index: 3,
      contentType: 'certificates',
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
                      leading: Image(image: AssetImage('assets/images/appicon.png'),),
                      title: (!Responsive.isMobile(context))
                          ? const NavigationButtonList()
                          : const SizedBox(),
                      actions: const [
                        ThemeToggleButton(),
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
                body: ScrollablePositionedList.builder(
                  itemScrollController: state.itemScrollController,
                  itemBuilder: (context, index) => pages[index],
                  itemCount: pages.length,
                )),
          );
        }),
      ),
    );
  }
}

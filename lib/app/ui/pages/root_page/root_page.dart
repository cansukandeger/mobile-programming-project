import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/core/color_manager.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../controllers/root_controller.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    RootController c = Get.put(RootController());
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: c.controller,
        screens: c.buildScreens,
        backgroundColor: ColorManager().primary,
        navBarHeight: 52,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Anasayfa",
            textStyle: TextStyle(
              color: ColorManager().secondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
            activeColorPrimary: ColorManager().secondary,
            inactiveColorPrimary: Colors.white70,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            textStyle: TextStyle(
              color: ColorManager().secondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
            title: "Arama",
            activeColorPrimary: ColorManager().secondary,
            inactiveColorPrimary: Colors.white70,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.checklist),
            textStyle: TextStyle(
              color: ColorManager().secondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
            title: "İlanlarım",
            activeColorPrimary: ColorManager().secondary,
            inactiveColorPrimary: Colors.white70,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.account_circle),
            textStyle: TextStyle(
              color: ColorManager().secondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
            title: "Profil",
            activeColorPrimary: ColorManager().secondary,
            inactiveColorPrimary: Colors.white70,
          ),
        ],
        confineInSafeArea: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.yellow,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}

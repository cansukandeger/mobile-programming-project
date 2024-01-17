import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/ui/pages/home_page/home_page.dart';
import 'package:mobilproje/app/ui/pages/myads_page/myads_page.dart';
import 'package:mobilproje/app/ui/pages/profile_page/profile_page.dart';
import 'package:mobilproje/app/ui/pages/search_page/search_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
class RootController extends GetxController {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  PersistentTabController get controller => _controller;

  List<Widget> buildScreens = [
    const HomePage(),
    const SearchPage(),
    const MyadsPage(),
    const ProfilePage(),
  ];
}

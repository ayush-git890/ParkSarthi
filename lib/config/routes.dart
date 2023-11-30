import 'package:ParkSarthi/pages/MapPage.dart';
import 'package:ParkSarthi/pages/about_us/about_us.dart';
import 'package:ParkSarthi/pages/homepage/homepage.dart';
import 'package:get/get.dart';

var pages = [
  GetPage(
    name: '/homepage',
    page: () => HomePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/about-us',
    page: () => AboutUs(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/map-page',
    page: () => MapPage(),
    transition: Transition.fade,
  ),
];

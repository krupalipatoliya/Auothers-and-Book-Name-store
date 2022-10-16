import 'package:firebasse_miner_one/screen/home_page.dart';
import 'package:firebasse_miner_one/screen/splash_screen.dart';
import 'package:firebasse_miner_one/utils/approuts.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().spalshScreen: (context) => const SplashScreen(),
  AppRoutes().homePage: (context) => const HomePage(),
};

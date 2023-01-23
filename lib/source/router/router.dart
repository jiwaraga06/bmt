import 'package:bmt/source/pages/Auth/login.dart';
import 'package:bmt/source/pages/Auth/splash.dart';
import 'package:bmt/source/pages/Menu/bottomNavBar.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterNavigation {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => Login());
      case BOTTOM_NAV_BAR:
        return MaterialPageRoute(builder: (context) => CustomBottomNavbar());
      default:
        return null;
    }
  }
}

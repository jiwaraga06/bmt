import 'package:bmt/source/pages/Auth/login.dart';
import 'package:bmt/source/pages/Auth/splash.dart';
import 'package:bmt/source/pages/Menu/PackingList/packinglist.dart';
import 'package:bmt/source/pages/Menu/Pulling/filter.dart';
import 'package:bmt/source/pages/Menu/Pulling/insert.dart';
import 'package:bmt/source/pages/Menu/Pulling/pulling.dart';
import 'package:bmt/source/pages/Menu/PutAway/filter.dart';
import 'package:bmt/source/pages/Menu/PutAway/insert.dart';
import 'package:bmt/source/pages/Menu/PutAway/putaway.dart';
import 'package:bmt/source/pages/Menu/ReceivePulling/receivepulling.dart';
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
      // PULINNG
      case PULLING:
        return MaterialPageRoute(builder: (context) => Pulling());
      case FILTER_PULLING:
        return MaterialPageRoute(builder: (context) => FilterPulling());
      case INSERT_PULLING:
        return MaterialPageRoute(builder: (context) => InsertPulling());
      // RECEIVE PULLING
      case RECEIVE_PULLING:
        return MaterialPageRoute(builder: (context) => ReceivePulling());
      // PACKINGLIST
      case PACKING_LIST:
        return MaterialPageRoute(builder: (context) => PacklingList());
      // PUT AWAY
      case PUT_AWAY:
        return MaterialPageRoute(builder: (context) => PutAway());
      case FILTER_PUT_AWAY:
        return MaterialPageRoute(builder: (context) => FilterPutAway());
      case INSERT_PUT_AWAY:
        return MaterialPageRoute(builder: (context) => InsertPutAway());
      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:moodly/router/router_name.dart';
import 'package:moodly/pages/login_page.dart';
import 'package:moodly/pages/landing_page.dart';
import 'package:moodly/pages/result_page.dart';
import 'package:moodly/pages/login_page.dart';
import 'package:moodly/pages/share_page.dart';
import 'package:moodly/router/deffered_loader.dart';
import 'package:qlevar_router/qlevar_router.dart';


class RouteGenerator {

  
  static final routes = <QRoute>[
    QRoute(
      name: RoutesName.LANDING_PAGE,
      path: '/', 
      builder: () => LandingPage()
    ),
    QRoute(
      name: RoutesName.LOGIN_PAGE,
      path: '/#/login', 
      builder: () => LoginPage()
    ),
    QRoute(
      name: RoutesName.RESULT_PAGE,
      path: '/#/result',
      builder: () => ResultPage()
    ),
    QRoute(
      name: RoutesName.SHARE_PAGE,
      path: '/#/share',
      builder: () => SharePage()
    ),
  ];

}
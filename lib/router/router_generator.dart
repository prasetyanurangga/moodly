import 'package:flutter/material.dart';
import 'package:moodly/router/router_name.dart';
import 'package:moodly/pages/login_page.dart';
import 'package:moodly/pages/landing_page.dart';
import 'package:moodly/pages/result_page.dart' deferred as result;
import 'package:moodly/pages/login_page.dart' deferred as login;
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
      path: '/login', 
      builder: () => login.LoginPage(),
      middleware: [
        DefferedLoader(login.loadLibrary),
      ],
    ),
    QRoute(
      name: RoutesName.RESULT_PAGE,
      path: '/result',
      builder: () => result.ResultPage(),
      middleware: [
        DefferedLoader(result.loadLibrary),
      ],
    ),
  ];

}
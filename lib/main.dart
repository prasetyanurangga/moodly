import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_bloc.dart';
import 'package:moodly/providers/api_provider.dart';
import 'package:moodly/repositories/main_repository.dart';
import 'package:moodly/router/router_name.dart';
import 'package:moodly/router/router_generator.dart';
import 'package:moodly/pages/not_found_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

 


void main() {
  QR.setUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    QR.settings.notFoundPage = QRoute(path: '/404', builder: ()=> NotFoundPage());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MainRepository>(
          create: (context) => MainRepository(),
          lazy: true,
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider  (
        providers: [
          BlocProvider<MoodlyBloc>(
            create: (context)  => MoodlyBloc(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Moodly',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme, 
            ),
          ),
          routeInformationParser: QRouteInformationParser(),
          routerDelegate: QRouterDelegate(RouteGenerator.routes)
        )
      ),
    );
  }
}

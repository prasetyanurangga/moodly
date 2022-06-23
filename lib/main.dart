import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_bloc.dart';
import 'package:moodly/providers/api_provider.dart';
import 'package:moodly/repositories/main_repository.dart';
import 'package:moodly/pages/not_found_page.dart';
import 'package:moodly/pages/landing_page.dart';
import 'package:moodly/pages/result_page.dart';
import 'package:moodly/pages/login_page.dart';
import 'package:moodly/pages/share_page.dart';
import 'package:url_strategy/url_strategy.dart';


 


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


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
        child: MaterialApp(
          title: 'Moodly',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme, 
            ),
          ),
          initialRoute: '/landing',
          routes: {
            '/landing': (context) => LandingPage(),
            '/login': (context) => LoginPage(),
            '/result': (context) => ResultPage(),
            '/share': (context) => SharePage(),
          },
        )
      ),
    );
  }
}

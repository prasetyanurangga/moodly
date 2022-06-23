import 'package:flutter/material.dart';
import 'package:moodly/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_event.dart';
import 'package:moodly/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'dart:html' as html;
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:spotify/spotify.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  void initState() {
    super.initState();

    getSpotify();
    
  }

  void getSpotify() async {


    var cookie = (html.window.document.cookie ?? "");
    var cookies = (html.window.document.cookie ?? "").split("=");
    var cookie_access_code = cookie.contains('access_token=') ? cookies[1] : "";
    var cookie_code = cookie.contains('code=') ? cookies[1] : "";

    if(cookie.contains('access_token=')){

      BlocProvider.of<MoodlyBloc>(context).add(
        GetSpotifyAudioFeature(
          accessCode: cookie_access_code
        )
      );


      Navigator.pushNamed(context, '/result');
    } else {
      if(cookie.contains('code=')){

        Dio dio = new Dio();
        dio.options.headers['content-type'] = "application/x-www-form-urlencoded";

        final clientId = const String.fromEnvironment('CLIENT_ID', defaultValue: '');
        final clientSecret = const String.fromEnvironment('CLIENT_SECRET', defaultValue: '');
        var result = await dio.post(
          'https://accounts.spotify.com/api/token',
          data: {
            "code": cookie_code,
            "client_id": clientId,
            "client_secret": clientSecret,
            "redirect_uri": 'http://localhost:12345/callback.html',
            "grant_type": "authorization_code",
            "code_verifier" : "TjDRHMNr74-x~O2~n-sf6QB0Ij8RZPGL5H2~I9V__meEyr5TQyYP1QbnBGHgM7pXt~XkPZf3UzNor~IK2LsOY1y7Ya6zgGl_E5KRrR_8rk7I7D.eRAE0vNxd7VVekO02"
          }
        );

        var responseBody = result.data;

        if(responseBody['access_token'] != ""){
          html.window.document.cookie = "access_token="+responseBody['access_token']+";max-age=3600;";
          html.window.document.cookie = "code=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
          html.window.localStorage["refresh_token"] = responseBody['refresh_token'];
          
          BlocProvider.of<MoodlyBloc>(context).add(
            GetSpotifyAudioFeature(
              accessCode: responseBody['access_token'],
            )
          );

          Navigator.pushNamed(context, '/result');

        } else {
          
          Navigator.pushNamed(context, '/login');
        }
      } else {
        
        Navigator.pushNamed(context, '/login');
      }
    }

    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildMain(){
    return Scaffold(
      body: Center(
        child: Text(
          "Moodly",
          style: Theme.of(context).textTheme.headline2?.copyWith(
            fontSize: 56.0, 
            fontWeight: FontWeight.w900,
            color: Colors.black
          )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}

import 'package:flutter/material.dart';
import 'package:moodly/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_event.dart';
import 'package:moodly/router/router_name.dart';
import 'package:moodly/utils/cookie_manager.dart';
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
    final loader = document.getElementById('loading_indicator');
    if(loader != null) {
      loader.remove();
    }
    getSpotify();
    
  }

  void getSpotify() async {
    var cookie =  CookieManager();
    print("ada id ? " +cookie.containCookie('id').toString());
    print("ada access_token ? " +cookie.containCookie('access_token').toString());
    print("ada code ? " +cookie.containCookie('code').toString());

    if(cookie.containCookie('id')){
      cookie.addToCookie("access_token","", "expires=Thu, 01 Jan 1970 00:00:00 UTC" );
      cookie.addToCookie("code","", "expires=Thu, 01 Jan 1970 00:00:00 UTC" );
      Navigator.pushNamed(context, '/share');
    } else {
      if(cookie.containCookie('access_token')){
        BlocProvider.of<MoodlyBloc>(context).add(
          GetSpotifyAudioFeature(
            accessCode: cookie.getCookie("access_token")
          )
        );


        Navigator.pushNamed(context, '/result');
      } else {
        if(cookie.containCookie('code')){

          Dio dio = new Dio();
          dio.options.headers['content-type'] = "application/x-www-form-urlencoded";

          final clientId = const String.fromEnvironment('CLIENT_ID', defaultValue: '');
          final clientSecret = const String.fromEnvironment('CLIENT_SECRET', defaultValue: '');
          var result = await dio.post(
            'https://accounts.spotify.com/api/token',
            data: {
              "code": cookie.getCookie('code'),
              "client_id": clientId,
              "client_secret": clientSecret,
              "redirect_uri": 'https://prasetyanurangga.github.io/moodly/callback.html',
              "grant_type": "authorization_code",
              "code_verifier" : "TjDRHMNr74-x~O2~n-sf6QB0Ij8RZPGL5H2~I9V__meEyr5TQyYP1QbnBGHgM7pXt~XkPZf3UzNor~IK2LsOY1y7Ya6zgGl_E5KRrR_8rk7I7D.eRAE0vNxd7VVekO02"
            }
          );

          var responseBody = result.data;

          if(responseBody['access_token'] != ""){
            cookie.addToCookie("access_token",responseBody['access_token'], "max-age=3600" );
            cookie.addToCookie("code","", "expires=Thu, 01 Jan 1970 00:00:00 UTC" );
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

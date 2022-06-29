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
import 'package:spotify/spotify.dart' as spotify;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  void initState() {
    super.initState();

    
    var cookie =  CookieManager();

    if(cookie.containCookie('access_token')){
      BlocProvider.of<MoodlyBloc>(context).add(
        GetSpotifyAudioFeature(
          accessCode: cookie.getCookie("access_token")
        )
      );
      Navigator.pushNamed(context, '/result');
    }

    if(cookie.containCookie('code')){
      Navigator.pushNamed(context, '/landing');
    }
    
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onLogin() async {
    
    final clientId = const String.fromEnvironment('CLIENT_ID', defaultValue: '');
    final clientSecret = const String.fromEnvironment('CLIENT_SECRET', defaultValue: '');
    final credentials = spotify.SpotifyApiCredentials(clientId, clientSecret);
    final grant = spotify.SpotifyApi.authorizationCodeGrant(credentials);
    final redirectUri = 'https://prasetyanurangga.github.io/moodly/callback.html';
    final scopes = ['user-top-read', 'playlist-read-private'];

    final authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes,
    );

    html.window.open(authUri.toString()+"&code_challenge_method=S256&code_challenge=Y-rYS_9VOLkbYhxle4yCsXrAO7h3RsRRE4r8a811KhE", '_self');

    
  }


  Widget _buildMain(){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Moodly",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontSize: 56.0, 
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                  )
                ),
                SizedBox(height: 16),

                ElevatedButton(  
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                  ),

                  onPressed: () {
                    onLogin();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Image.asset(
                          'assets/icons/Spotify.png',
                          height: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Sign in with Spotify",
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                          )
                        )
                      ],
                    )
                  )
                ),
                
              ]
            )
          )
        ) 
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}

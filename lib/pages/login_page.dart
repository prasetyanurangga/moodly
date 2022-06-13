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


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  void initState() {
    super.initState();
    getSpotify();
    
  }

  void getSpotify() async {

    if(html.window.localStorage.containsKey("code")){

      final String itemName = html.window.localStorage["code"] ?? "";
      Dio dio = new Dio();
      dio.options.headers['content-type'] = "application/x-www-form-urlencoded";

      final clientId = const String.fromEnvironment('CLIENT_ID', defaultValue: '');
      final clientSecret = const String.fromEnvironment('CLIENT_SECRET', defaultValue: '');
      var result = await dio.post(
        'https://accounts.spotify.com/api/token',
        data: {
          "code": itemName,
          "client_id": clientId,
          "client_secret": clientSecret,
          "redirect_uri": 'https://prasetyanurangga.github.io/moodly/callback.html',
          "grant_type": "authorization_code",
          "code_verifier" : "TjDRHMNr74-x~O2~n-sf6QB0Ij8RZPGL5H2~I9V__meEyr5TQyYP1QbnBGHgM7pXt~XkPZf3UzNor~IK2LsOY1y7Ya6zgGl_E5KRrR_8rk7I7D.eRAE0vNxd7VVekO02"
        }
      );

      var responseBody = result.data;

      if(responseBody['access_token'] != ""){
        html.window.localStorage["access_token"] = responseBody['access_token'];
        print(responseBody['access_token']);

        BlocProvider.of<MoodlyBloc>(context).add(
          GetSpotifyAudioFeature(
            accessCode: responseBody['access_token'],
          )
        );

        QR.toName(RoutesName.RESULT_PAGE);
        
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onLogin() async {
    
    final clientId = const String.fromEnvironment('CLIENT_ID', defaultValue: '');
    final clientSecret = const String.fromEnvironment('CLIENT_SECRET', defaultValue: '');
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final grant = SpotifyApi.authorizationCodeGrant(credentials);
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
      body: ResponsiveLayoutBuilder(
        small: (_, __)  => Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Container(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snaptify",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 56.0, 
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      onLogin();
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                    ),
                  )
                ]
              )
            )
          ) 
        ),
        medium: (_, __) => Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Container(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snaptify",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 56.0, 
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      onLogin();
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                    ),
                  )
                ]
              )
            )
          ) 
        ),
        large: (_, __) => Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Container(
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Snaptify",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 56.0, 
                      fontWeight: FontWeight.w900,
                      color: Colors.black
                    )
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      onLogin();
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                    ),
                  )
                ]
              )
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

import 'package:dio/dio.dart';
import 'dart:async';
import 'package:moodly/constant/strings.dart';
import 'dart:convert';


class ApiProvider{


  Dio getDio(String accessCode){
    final baseUrl = const String.fromEnvironment('BASE_URL', defaultValue: '');
    var options = BaseOptions(
      baseUrl: baseUrl,
      headers : {
        'access_token' : accessCode
      }
    );


    Dio dio = Dio(options);

    return dio;
  }

  Dio getDioAnother(){
    final baseUrl = const String.fromEnvironment('BASE_URL', defaultValue: '');
    var options = BaseOptions(
      baseUrl: baseUrl,
    );
    Dio dio = Dio(options);

    return dio;
  }

  Future<Response> GetSpotifyAudioFeature(String accessCode) async {
    String _endpoint = "/get_spotify";
    Response response;

    try {
      response = await getDio(accessCode).get(
        _endpoint
      );
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
    return response;
  }

  Future<Response> GetSpotifyAudioFeatureById(String id) async {
    String _endpoint = "/get_user";
    Response response;

    try {
      response = await getDioAnother().get(
        _endpoint,
        queryParameters: {'id': id}
      );
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
    return response;
  }
}

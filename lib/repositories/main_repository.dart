import 'package:moodly/models/moodly_response_model.dart';
import 'package:moodly/providers/response_data.dart';
import 'package:moodly/providers/api_provider.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MainRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<ResponseData> GetSpotifyAudioFeature(String accessCode) async{
  	Response response = await _apiProvider.GetSpotifyAudioFeature(accessCode);
  	MoodlyResponseModel responseJust = MoodlyResponseModel.fromJson(response.data);
  	if (responseJust == null) {
      return ResponseData.connectivityError();
    }

    if (response.statusCode == 200) {
      return ResponseData.success(responseJust);
    } else {
      return ResponseData.error("Error");
    }
  }
}
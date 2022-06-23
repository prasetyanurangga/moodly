import 'dart:async';

import 'package:moodly/blocs/moodly_bloc/moodly_event.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_state.dart';
import 'package:moodly/models/moodly_response_model.dart';
import 'package:moodly/providers/response_data.dart';
import 'package:moodly/repositories/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class MoodlyBloc extends Bloc<MoodlyEvent, MoodlyState> {
  MainRepository mainRepository = MainRepository();

  MoodlyBloc() : super(MoodlyInitial()) {
    on<GetSpotifyAudioFeature>((event, emit) async {
      emit(MoodlyLoading());
      try {
        final ResponseData<dynamic> response = await mainRepository.GetSpotifyAudioFeature(event.accessCode);
        var finalResponse = response.data;
        if (response.status == Status.ConnectivityError) {
          emit(const MoodlyFailure(error: ""));
        }
        if (response.status == Status.Success) {
          emit(MoodlySuccess(data: finalResponse.data as Data));
        } else {
          print( response.message);
          emit(MoodlyFailure(error: response.message ??  "Error"));
        }
      } catch (error) {
        print(error);
        emit(MoodlyFailure(error: error.toString()));
      }
    });

    on<GetSpotifyAudioFeatureById>((event, emit) async {
      emit(MoodlyLoading());
      try {
        final ResponseData<dynamic> response = await mainRepository.GetSpotifyAudioFeatureById(event.id);
        var finalResponse = response.data;
        if (response.status == Status.ConnectivityError) {
          emit(const MoodlyFailure(error: ""));
        }
        if (response.status == Status.Success) {
          emit(MoodlySuccess(data: finalResponse.data as Data));
        } else {
          print( response.message);
          emit(MoodlyFailure(error: response.message ??  "Error"));
        }
      } catch (error) {
        print(error);
        emit(MoodlyFailure(error: error.toString()));
      }
    });
  }

}

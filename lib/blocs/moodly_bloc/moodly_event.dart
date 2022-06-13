import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MoodlyEvent extends Equatable {
  const MoodlyEvent();
  @override
  List<Object> get props => [];
}

class GetSpotifyAudioFeature extends MoodlyEvent {
  final String accessCode;
  GetSpotifyAudioFeature({
    required this.accessCode
  });
}
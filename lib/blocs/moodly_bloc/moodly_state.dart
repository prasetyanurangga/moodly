import 'package:moodly/models/moodly_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MoodlyState extends Equatable {
  const MoodlyState();

  @override
  List<Object> get props => [];
}

class MoodlyInitial extends MoodlyState {}

class MoodlyLoading extends MoodlyState {}

class MoodlySuccess extends MoodlyState {
  final Data data;

  MoodlySuccess({required this.data});

}

class MoodlyFailure extends MoodlyState {
  final String error;

  const MoodlyFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MoodlyFailure { error: $error }';
}
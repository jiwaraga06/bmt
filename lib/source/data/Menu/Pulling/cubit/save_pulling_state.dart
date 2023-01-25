part of 'save_pulling_cubit.dart';

@immutable
abstract class SavePullingState {}

class SavePullingInitial extends SavePullingState {}

class SavePullingLoading extends SavePullingState {}

class SavePullingLoaded extends SavePullingState {
  final int? statusCode;
  dynamic json;

  SavePullingLoaded({this.statusCode, this.json});
}

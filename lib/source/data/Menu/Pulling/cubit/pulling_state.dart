part of 'pulling_cubit.dart';

@immutable
abstract class PullingState {}

class PullingInitial extends PullingState {}

class PullingLoading extends PullingState {}

class PullingLoaded extends PullingState {
  final int? statusCode;
  dynamic json;

  PullingLoaded({this.json, this.statusCode});
}

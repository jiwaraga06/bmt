part of 'putaway_cubit.dart';

@immutable
abstract class PutawayState {}

class PutawayInitial extends PutawayState {}

class PutawayLoading extends PutawayState {}

class PutawayLoaded extends PutawayState {
  final int? statusCode;
  dynamic json;

  PutawayLoaded({this.statusCode, this.json});
}

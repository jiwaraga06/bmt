part of 'workcenter_cubit.dart';

@immutable
abstract class WorkcenterState {}

class WorkcenterInitial extends WorkcenterState {}

class SkipWorkcenterLoading extends WorkcenterState {}

class SkipWorkcenterLoaded extends WorkcenterState {
  final int? statusCode;
  final String? message;
  dynamic json;

  SkipWorkcenterLoaded({this.statusCode, this.message, this.json});
}

class UnSkipWorkcenterLoading extends WorkcenterState {}

class UnSkipWorkcenterLoaded extends WorkcenterState {
  final int? statusCode;
  final String? message;
  dynamic json;

  UnSkipWorkcenterLoaded({this.statusCode, this.message, this.json});
}

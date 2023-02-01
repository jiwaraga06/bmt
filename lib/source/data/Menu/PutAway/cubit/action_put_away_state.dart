part of 'action_put_away_cubit.dart';

@immutable
abstract class ActionPutAwayState {}

class ActionPutAwayInitial extends ActionPutAwayState {}

class ActionDeletePutAwayLoading extends ActionPutAwayState {}

class ActionDeletePutAwayLoaded extends ActionPutAwayState {
  final int? statusCode;
  dynamic json;

  ActionDeletePutAwayLoaded({this.statusCode, this.json});
}

class ActionPrintPutAwayLoading extends ActionPutAwayState {}

class ActionPrintPutAwayLoaded extends ActionPutAwayState {
  final int? statusCode;
  dynamic json;

  ActionPrintPutAwayLoaded({this.statusCode, this.json});
}

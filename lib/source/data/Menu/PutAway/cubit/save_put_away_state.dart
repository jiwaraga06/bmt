part of 'save_put_away_cubit.dart';

@immutable
abstract class SavePutAwayState {}

class SavePutAwayInitial extends SavePutAwayState {}

class SavePutAwayLoading extends SavePutAwayState {}

class SavePutAwayLoaded extends SavePutAwayState {
  final int? statusCode;
  dynamic json;

  SavePutAwayLoaded({this.statusCode, this.json});
}

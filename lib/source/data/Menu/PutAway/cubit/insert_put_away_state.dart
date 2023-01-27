part of 'insert_put_away_cubit.dart';

@immutable
abstract class InsertPutAwayState {}

class InsertPutAwayInitial extends InsertPutAwayState {}

class InsertPutAwayLoading extends InsertPutAwayState {}

class InsertPutAwayLoaded extends InsertPutAwayState {
  final int? statusCode;
  dynamic json;

  InsertPutAwayLoaded({this.statusCode, this.json});
}

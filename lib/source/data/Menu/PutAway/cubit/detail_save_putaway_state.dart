part of 'detail_save_putaway_cubit.dart';

@immutable
abstract class DetailSavePutawayState {}

class DetailSavePutawayInitial extends DetailSavePutawayState {}

class DetailSavePutawayLoading extends DetailSavePutawayState {}

class DetailSavePutawayLoaded extends DetailSavePutawayState {
  final int? statusCode;
  dynamic json;

  DetailSavePutawayLoaded({this.statusCode, this.json});
}

class SaveDataPutawayLoading extends DetailSavePutawayState {}

class SaveDataPutawayLoaded extends DetailSavePutawayState {
  final int? statusCode;
  dynamic json;

  SaveDataPutawayLoaded({this.statusCode, this.json});
}

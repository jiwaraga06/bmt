part of 'detail_packing_save_cubit.dart';

@immutable
abstract class DetailPackingSaveState {}

class DetailPackingSaveInitial extends DetailPackingSaveState {}

class DetailPackingSaveLoading extends DetailPackingSaveState {}

class DetailPackingSaveLoaded extends DetailPackingSaveState {
  final int? statusCode;
  dynamic json;

  DetailPackingSaveLoaded({this.statusCode, this.json});
}

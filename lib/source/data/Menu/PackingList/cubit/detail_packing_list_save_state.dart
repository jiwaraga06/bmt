part of 'detail_packing_list_save_cubit.dart';

@immutable
abstract class DetailPackingListSaveState {}

class DetailPackingListSaveInitial extends DetailPackingListSaveState {}

class DetailPackingListSaveLoading extends DetailPackingListSaveState {}

class DetailPackingListSaveLoaded extends DetailPackingListSaveState {
  final int? statusCode;
  dynamic json;

  DetailPackingListSaveLoaded({this.statusCode, this.json});
}

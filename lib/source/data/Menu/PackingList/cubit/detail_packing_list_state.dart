part of 'detail_packing_list_cubit.dart';

@immutable
abstract class DetailPackingListState {}

class DetailPackingListInitial extends DetailPackingListState {}

class DetailPackingListLoading extends DetailPackingListState {}

class DetailPackingListLoaded extends DetailPackingListState {
  final int? statusCode;
  dynamic json;

  DetailPackingListLoaded({this.statusCode, this.json});
}

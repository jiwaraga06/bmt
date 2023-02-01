part of 'detail_packing_get_cubit.dart';

@immutable
abstract class DetailPackingGetState {}

class DetailPackingGetInitial extends DetailPackingGetState {}
class DetailPackingGetLoading extends DetailPackingGetState {}
class DetailPackingGetLoaded extends DetailPackingGetState {
  final int? statusCode;
  dynamic json;

  DetailPackingGetLoaded({this.statusCode, this.json});

}

part of 'header_packing_list_cubit.dart';

@immutable
abstract class HeaderPackingListState {}

class HeaderPackingListInitial extends HeaderPackingListState {}

class HeaderPackingListData extends HeaderPackingListState {
  final String? doNumber;
  final String? soldTo;
  final String? date;
  final String? dateDelivery;

  HeaderPackingListData({this.doNumber, this.soldTo, this.date, this.dateDelivery});
}
class HeaderPackingListLoading extends HeaderPackingListState {}

class HeaderPackingListLoaded extends HeaderPackingListState {
  final int? statusCode;
  dynamic json;

  HeaderPackingListLoaded({this.statusCode, this.json});
}

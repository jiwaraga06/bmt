part of 'packing_list_cubit.dart';

@immutable
abstract class PackingListState {}

class PackingListInitial extends PackingListState {}

class PackingListLoading extends PackingListState {}

class PackingListLoaded extends PackingListState {
  final int? statusCode;
  dynamic json;

  PackingListLoaded({this.statusCode, this.json});
}

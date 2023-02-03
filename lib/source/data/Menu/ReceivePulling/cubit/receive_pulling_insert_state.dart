part of 'receive_pulling_insert_cubit.dart';

@immutable
abstract class ReceivePullingInsertState {}

class ReceivePullingInsertInitial extends ReceivePullingInsertState {}

class ReceivePullingInsertLoading extends ReceivePullingInsertState {}

class ReceivePullingInsertLoaded extends ReceivePullingInsertState {
  final int? statusCode;
  dynamic json;

  ReceivePullingInsertLoaded({this.statusCode, this.json});
}

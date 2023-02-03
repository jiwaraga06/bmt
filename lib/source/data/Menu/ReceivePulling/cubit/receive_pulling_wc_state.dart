part of 'receive_pulling_wc_cubit.dart';

@immutable
abstract class ReceivePullingWcState {}

class ReceivePullingWcInitial extends ReceivePullingWcState {}

class ReceivePullingWcLoading extends ReceivePullingWcState {}

class ReceivePullingWcLoaded extends ReceivePullingWcState {
  final int? statusCode;
  dynamic json;

  ReceivePullingWcLoaded({this.statusCode, this.json});
}

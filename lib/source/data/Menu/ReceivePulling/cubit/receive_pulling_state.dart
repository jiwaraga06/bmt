part of 'receive_pulling_cubit.dart';

@immutable
abstract class ReceivePullingState {}

class ReceivePullingInitial extends ReceivePullingState {}

class ReceivePullingLoading extends ReceivePullingState {}

class ReceivePullingLoaded extends ReceivePullingState {
  final int? statusCode;
  final String? shift;
  dynamic json;

  ReceivePullingLoaded({this.statusCode, this.shift, this.json});
}

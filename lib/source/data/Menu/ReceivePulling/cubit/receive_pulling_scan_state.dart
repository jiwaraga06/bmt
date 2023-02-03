part of 'receive_pulling_scan_cubit.dart';

@immutable
abstract class ReceivePullingScanState {}

class ReceivePullingScanInitial extends ReceivePullingScanState {}

class ReceivePullingScanLoading extends ReceivePullingScanState {}

class ReceivePullingScanLoaded extends ReceivePullingScanState {
  final int? statusCode;
  dynamic json;

  ReceivePullingScanLoaded({this.statusCode, this.json});
}

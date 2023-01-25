part of 'insert_scan_cubit.dart';

@immutable
abstract class InsertScanState {}

class InsertScanInitial extends InsertScanState {}

class InsertScanLoading extends InsertScanState {}

class InsertScanLoaded extends InsertScanState {
  final int? statusCode;
  dynamic json;

  InsertScanLoaded({this.statusCode, this.json});
}

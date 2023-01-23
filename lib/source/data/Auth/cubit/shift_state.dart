part of 'shift_cubit.dart';

@immutable
abstract class ShiftState {}

class ShiftInitial extends ShiftState {}

class ShiftLoading extends ShiftState {}

class ShiftLoaded extends ShiftState {
  dynamic json;
  
  ShiftLoaded({this.json});
}

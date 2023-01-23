import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'shift_state.dart';

class ShiftCubit extends Cubit<ShiftState> {
  final MyRepository? myRepository;
  ShiftCubit({required this.myRepository}) : super(ShiftInitial());

  void getShift() async {
    emit(ShiftLoading());
    myRepository!.getShift().then((value) {
      var json = jsonDecode(value.body);
      print("SHIFT: $json");
      emit(ShiftLoaded(json: json));
    });
  }
}

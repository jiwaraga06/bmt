import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receive_pulling_wc_state.dart';

class ReceivePullingWcCubit extends Cubit<ReceivePullingWcState> {
  final MyRepository? myRepository;
  ReceivePullingWcCubit({required this.myRepository}) : super(ReceivePullingWcInitial());

  void getReceiveWorkCenter() async {
    emit(ReceivePullingWcLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    myRepository!.receiveWorkCenter(nik).then((value) {
      var json = jsonDecode(value.body);
      print('Receive WC: $json');
      if (value.statusCode == 200) {
        emit(ReceivePullingWcLoaded(json: json, statusCode: 200));
      } else {
        emit(ReceivePullingWcLoaded(json: json, statusCode: 400));
      }
    });
  }
}

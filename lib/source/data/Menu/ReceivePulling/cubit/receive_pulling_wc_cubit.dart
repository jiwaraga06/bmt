import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receive_pulling_wc_state.dart';

class ReceivePullingWcCubit extends Cubit<ReceivePullingWcState> {
  final MyRepository? myRepository;
  ReceivePullingWcCubit({required this.myRepository}) : super(ReceivePullingWcInitial());
  var list = [];
  void getReceiveWorkCenter() async {
    emit(ReceivePullingWcLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    myRepository!.receiveWorkCenter(nik).then((value) {
      var json = jsonDecode(value.body);
      list = json;
      print('Receive WC: $json');
      if (value.statusCode == 200) {
        emit(ReceivePullingWcLoaded(json: json, statusCode: 200));
      } else {
        emit(ReceivePullingWcLoaded(json: json, statusCode: 400));
      }
    });
  }

  void getReceiveWorkCenterSearch(value) async {
    emit(ReceivePullingWcLoading());
    var result = value;
    var hasil = list.where((e) => e['display'].toLowerCase().contains(result.toLowerCase())).toList();
    if (result == '') {
      emit(ReceivePullingWcLoaded(json: list, statusCode: 200));
    } else {
      emit(ReceivePullingWcLoaded(json: hasil, statusCode: 400));
    }
  }
}

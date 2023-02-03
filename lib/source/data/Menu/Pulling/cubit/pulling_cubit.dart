import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pulling_state.dart';

class PullingCubit extends Cubit<PullingState> {
  final MyRepository? myRepository;
  PullingCubit({required this.myRepository}) : super(PullingInitial());
  var list = [];

  void getPulling(tgl_awal, tgl_akhir) async {
    emit(PullingLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    print(barcode);
    myRepository!.getPulling(barcode, tgl_awal, tgl_akhir).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print("Pulling: $json");
      if (value.statusCode == 200) {
        emit(PullingLoaded(json: json['rows'], statusCode: 200));
      } else {
        emit(PullingLoaded(json: {'message': 'Error'}, statusCode: 400));
      }
    });
  }

  void getCurrentPulling() async {
    emit(PullingLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    print(barcode);
    var date = DateTime.now();
    var tanggal = date.toString().split(' ')[0];
    myRepository!.getPulling(barcode, tanggal, tanggal).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print("Pulling: $json");
      if (value.statusCode == 200) {
        emit(PullingLoaded(json: json['rows'], statusCode: value.statusCode));
      } else {
        emit(PullingLoaded(json: {'message': 'Error'}, statusCode: value.statusCode));
      }
    });
  }

  void searchData(value) async {
    emit(PullingLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['wopl_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(PullingLoaded(statusCode: 200, json: list));
    } else {
      print('ada');
      emit(PullingLoaded(statusCode: 200, json: hasil));
    }
  }
}

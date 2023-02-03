import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receive_pulling_state.dart';

class ReceivePullingCubit extends Cubit<ReceivePullingState> {
  final MyRepository? myRepository;
  ReceivePullingCubit({required this.myRepository}) : super(ReceivePullingInitial());
  var list = [];

  void recevieGet(tanggalAwal, tanggalAkhir) async {
    emit(ReceivePullingLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    var shift = pref.getString('shift');
    print(barcode);
    myRepository!.recevieGet(barcode, tanggalAwal, tanggalAkhir).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print('Receive: $json');
      if (value.statusCode == 200) {
        emit(ReceivePullingLoaded(json: json['rows'], statusCode: 200,shift: shift));
      } else {
        emit(ReceivePullingLoaded(json: json['rows'], statusCode: 400));
      }
    });
  }

  void recevieGetCurrent() async {
    emit(ReceivePullingLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    var shift = pref.getString('shift');
    print(barcode);
    var date = DateTime.now();
    var tanggal = date.toString().split(' ')[0];
    myRepository!.recevieGet(barcode, tanggal, tanggal).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print('Receive: $json');
      if (value.statusCode == 200) {
        emit(ReceivePullingLoaded(json: json['rows'], statusCode: 200, shift: shift));
      } else {
        emit(ReceivePullingLoaded(json: json['rows'], statusCode: 400));
      }
    });
  }

  void searchData(value) async {
    emit(ReceivePullingLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['wopl_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(ReceivePullingLoaded(json: list, statusCode: 200));
    } else {
      print('ada');
      emit(ReceivePullingLoaded(json: hasil, statusCode: 200));
    }
  }
}

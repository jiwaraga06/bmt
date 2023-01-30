import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'packing_list_state.dart';

class PackingListCubit extends Cubit<PackingListState> {
  final MyRepository? myRepository;
  PackingListCubit({required this.myRepository}) : super(PackingListInitial());
  var list = [];
  void getPackingList(tanggalAwal, tanggalAkhir) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    emit(PackingListLoading());
    myRepository!.getPackingList(barcode, tanggalAwal, tanggalAkhir).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print('PACKING LIST: $json');
      if (value.statusCode == 200) {
        emit(PackingListLoaded(statusCode: 200, json: json['rows']));
      } else {
        emit(PackingListLoaded(statusCode: 400, json: json));
      }
    });
  }

  void getPackingListCurrent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    var date = DateTime.now();
    var tanggal = date.toString().split(' ')[0];
    emit(PackingListLoading());
    myRepository!.getPackingList(barcode, tanggal, tanggal).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print('PACKING LIST: $json');
      if (value.statusCode == 200) {
        emit(PackingListLoaded(statusCode: 200, json: json['rows']));
      } else {
        emit(PackingListLoaded(statusCode: 400, json: json));
      }
    });
  }

  void searchData(value) async {
    emit(PackingListLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['do_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(PackingListLoaded(json: list, statusCode: 200));
    } else {
      print('ada');
      emit(PackingListLoaded(json: hasil, statusCode: 200));
    }
  }
}

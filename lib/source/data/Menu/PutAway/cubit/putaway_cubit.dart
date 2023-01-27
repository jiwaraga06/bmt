import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'putaway_state.dart';

class PutawayCubit extends Cubit<PutawayState> {
  final MyRepository? myRepository;
  PutawayCubit({required this.myRepository}) : super(PutawayInitial());
  var list = [];

  void putaway(tglAwal, tglAkhir) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    emit(PutawayLoading());
    myRepository!.putaway(scan, tglAwal, tglAkhir).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print('PUT AWAY: $json');
      if (json['status'] == 'success') {
        emit(PutawayLoaded(json: json['rows'], statusCode: 200));
      } else {
        emit(PutawayLoaded(json: json['rows'], statusCode: 400));
      }
    });
  }

  void currentPutaway() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    emit(PutawayLoading());
    var date = DateTime.now();
    var tanggal = date.toString().split(' ')[0];
    myRepository!.putaway(scan, tanggal, tanggal).then((value) {
      var json = jsonDecode(value.body);
      list = json['rows'];
      print('PUT AWAY: $json');
      if (json['status'] == 'success') {
        emit(PutawayLoaded(json: json['rows'], statusCode: 200));
      } else {
        emit(PutawayLoaded(json: json['rows'], statusCode: 400));
      }
    });
  }

  void searchData(value) async {
    emit(PutawayLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['packld_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(PutawayLoaded(json: list, statusCode: 200));
    } else {
      print('ada');
      emit(PutawayLoaded(json: hasil, statusCode: 200));
    }
  }
}

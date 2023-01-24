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

  void getPulling(tgl_awal, tgl_akhir) async {
    emit(PullingLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    print(barcode);
    myRepository!.getPulling(barcode, tgl_awal, tgl_akhir).then((value) {
      var json = jsonDecode(value.body);
      print("Pulling: $json");
      if (value.statusCode == 200) {
        emit(PullingLoaded(json: json['rows'], statusCode: value.statusCode));
      } else {
        emit(PullingLoaded(json: {'message': 'Error'}, statusCode: value.statusCode));
      }
    });
  }
}

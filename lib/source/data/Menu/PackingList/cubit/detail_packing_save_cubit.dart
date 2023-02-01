import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_packing_save_state.dart';

class DetailPackingSaveCubit extends Cubit<DetailPackingSaveState> {
  final MyRepository? myRepository;
  DetailPackingSaveCubit({required this.myRepository}) : super(DetailPackingSaveInitial());

  void savePackingList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('scan');
    emit(DetailPackingSaveLoading());
    var body = {};
    myRepository!.packingListDetailSave(body).then((value) {
      var json = jsonDecode(value.body);
      print('Result Save packing list: $json');
      if (json['status'] == 'success') {
        emit(DetailPackingSaveLoaded(json: json, statusCode: 200));
      } else {
        emit(DetailPackingSaveLoaded(json: json, statusCode: 400));
      }
    });
  }
}

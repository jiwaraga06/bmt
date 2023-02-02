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
    emit(DetailPackingSaveLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('scan');
    var body = {
      "username": '$username',
    };
    print(body);
    myRepository!.packingListDetailSave(body).then((value) {
      var statusCode = value.statusCode;
      print(statusCode);
      if (statusCode == 500) {
        emit(DetailPackingSaveLoaded(json: {'msg': 'Save Failed code: 500'}, statusCode: 500));
      } else {
        var json = jsonDecode(value.body);
        print('Result Save packing list: $json');
        if (json['status'] != 'error') {
          emit(DetailPackingSaveLoaded(json: json, statusCode: 200));
        } else {
          emit(DetailPackingSaveLoaded(json: json, statusCode: 400));
        }
      }
    });
  }
}

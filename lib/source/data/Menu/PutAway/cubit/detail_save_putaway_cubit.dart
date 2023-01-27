import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_save_putaway_state.dart';

class DetailSavePutawayCubit extends Cubit<DetailSavePutawayState> {
  final MyRepository? myRepository;
  DetailSavePutawayCubit({required this.myRepository}) : super(DetailSavePutawayInitial());

  void getDetailSavePutAway() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    emit(DetailSavePutawayLoading());
    myRepository!.putawayDetailSave(scan).then((value) {
      var json = jsonDecode(value.body);
      print('JSON DETAIL SAVE: $json');
      emit(DetailSavePutawayLoaded(json: json, statusCode: 200));
    });
  }

  void clearDetailSavePutAway() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var body = {
      "usernik": scan,
    };
    print(body);
    myRepository!.clearDetailSavePutAway(body).then((value) {
      var statusCode = value.statusCode;
      print(statusCode);
    });
  }

  void saveDataPutAway() async {
    emit(SaveDataPutawayLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var body = {
      "username": scan,
    };
    print(body);
    myRepository!.saveDataPutAway(body).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('SAVE DATA: $json');
      if (json['status'] != 'error') {
        emit(SaveDataPutawayLoaded(json: json, statusCode: 200));
      } else {
        emit(SaveDataPutawayLoaded(json: json, statusCode: 400));
      }
    });
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'save_put_away_state.dart';

class SavePutAwayCubit extends Cubit<SavePutAwayState> {
  final MyRepository? myRepository;
  SavePutAwayCubit({required this.myRepository}) : super(SavePutAwayInitial());

  void savePutAway(qty, wooid, qtyAvailable, boxNum, lotSerial, woploid, woplcodebox, customer, customerName, woptid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var shift = pref.getString('shift');
    var body = {
      "serial": lotSerial,
      "qty": qty,
      "wo_oid": wooid,
      "qty_available": qtyAvailable,
      "wopl_oid": woploid,
      "wopl_code_box": woplcodebox,
      "wo_mr_code": "",
      "customer": customer,
      "customer_name": customerName,
      "wop_pt_id": woptid,
      "nik": scan,
      "shift": shift,
    };
    print(body);
    emit(SavePutAwayLoading());
    myRepository!.saveputaway(body).then((value) {
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        print('SAVE PUT AWAY: $json');
        if (json['status'] != 'error') {
          emit(SavePutAwayLoaded(json: json, statusCode: 200));
        } else {
          emit(SavePutAwayLoaded(json: json, statusCode: 400));
        }
      } else {
        emit(SavePutAwayLoaded(json: {'msg': 'Error: ${value.statusCode}'}, statusCode: value.statusCode));
      }
    });
  }
}

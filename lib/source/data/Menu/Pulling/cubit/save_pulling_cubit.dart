import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'save_pulling_state.dart';

class SavePullingCubit extends Cubit<SavePullingState> {
  final MyRepository? myRepository;
  SavePullingCubit({required this.myRepository}) : super(SavePullingInitial());

  void savePulling(boxNumber, qtyOk, qtyRepair, qtyNG, wcToID, wcFromID, qtyReal, status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    var shift = pref.getString('shift');
    var username = pref.getString('username');
    var body = {
      "nik": nik,
      "sift": shift,
      "box_number": boxNumber,
      "qty_ok": qtyOk,
      "qty_repair": qtyRepair,
      "qty_ng": qtyNG,
      "wc_to_id": wcToID,
      "wc_from_id": wcFromID,
      "qty_real": qtyReal,
      "status": status,
    };
    print(jsonEncode(body));
    emit(SavePullingLoading());
    myRepository!.pullingSave(body).then((value) {
        print(value.statusCode);
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        print('Save Pulling:  $json');
        if (json['status'] == 'error') {
          emit(SavePullingLoaded(json: json['msg'], statusCode: 400));
        } else {
          emit(SavePullingLoaded(json: json['msg'], statusCode: 200));
        }
      } else {
        emit(SavePullingLoaded(json: 'Error: ${value.statusCode}', statusCode: value.statusCode));
      }
    });
  }
}

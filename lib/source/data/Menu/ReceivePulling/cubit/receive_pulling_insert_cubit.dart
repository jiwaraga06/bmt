import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receive_pulling_insert_state.dart';

class ReceivePullingInsertCubit extends Cubit<ReceivePullingInsertState> {
  final MyRepository? myRepository;
  ReceivePullingInsertCubit({required this.myRepository}) : super(ReceivePullingInsertInitial());

  void saveReceivePulling(box_number, qty_receive, qty_repair, qty_ng, work_center, work_order, wopl_oid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    var shift = pref.getString('shift');
    var body = {
      'nik': nik,
      'sift': shift,
      'box_number': box_number,
      'qty_receive': qty_receive,
      'qty_repair': qty_repair,
      'qty_ng': qty_ng,
      'work_center': work_center,
      'work_order': work_order,
      'wopl_oid': wopl_oid,
    };
    print(body);
    emit(ReceivePullingInsertLoading());
    myRepository!.receiveSave(body).then((value) {
      var json = jsonDecode(value.body);
      print('RECEIVE SAVE: $json');
      if (json['staus'] == 'error') {
        emit(ReceivePullingInsertLoaded(json: json, statusCode: 400));
      } else {
        emit(ReceivePullingInsertLoaded(json: json, statusCode: 200));
      }
    });
  }
}

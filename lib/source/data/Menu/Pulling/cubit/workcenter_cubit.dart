import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'workcenter_state.dart';

class WorkcenterCubit extends Cubit<WorkcenterState> {
  final MyRepository? myRepository;
  WorkcenterCubit({required this.myRepository}) : super(WorkcenterInitial());

  void skipWorkCenter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var shift = pref.getString('shift');
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        emit(SkipWorkcenterLoading());
        myRepository!.pullingskipwc(shift, scan, barcodeScanRes).then((value) {
          var json = jsonDecode(value.body);
          print('Skip WC: $json');
          if (json['status'] == 'success') {
            emit(SkipWorkcenterLoaded(json: json, statusCode: 200, message: 'Skip Success !'));
          } else {
            emit(SkipWorkcenterLoaded(json: json, statusCode: 400, message: 'Skip Failed !'));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void unskipWorkCenter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var shift = pref.getString('shift');
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        emit(UnSkipWorkcenterLoading());
        myRepository!.pullingunskipwc(shift, scan, barcodeScanRes).then((value) {
          var json = jsonDecode(value.body);
          print('Un Skip WC: $json');
          if (json['status'] == 'success') {
            emit(UnSkipWorkcenterLoaded(json: json, statusCode: 200, message: 'UnSkip Success !'));
          } else {
            emit(UnSkipWorkcenterLoaded(json: json, statusCode: 400, message: 'UnSkip Failed !'));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}

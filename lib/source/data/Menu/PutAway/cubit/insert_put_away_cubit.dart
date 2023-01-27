import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'insert_put_away_state.dart';

class InsertPutAwayCubit extends Cubit<InsertPutAwayState> {
  final MyRepository? myRepository;
  InsertPutAwayCubit({required this.myRepository}) : super(InsertPutAwayInitial());

  void scan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var shift = pref.getString('shift');
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      emit(InsertPutAwayLoading());
      if (barcodeScanRes != '-1') {
        myRepository!.putawayScan(barcodeScanRes, scan, shift).then((value) {
          var json = jsonDecode(value.body);
          print('Put Away Scan: $json');
          if (json['status'] == 'success') {
            emit(InsertPutAwayLoaded(json: json, statusCode: value.statusCode));
          } else {
            emit(InsertPutAwayLoaded(json: json, statusCode: value.statusCode));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}

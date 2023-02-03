import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receive_pulling_scan_state.dart';

class ReceivePullingScanCubit extends Cubit<ReceivePullingScanState> {
  final MyRepository? myRepository;
  ReceivePullingScanCubit({required this.myRepository}) : super(ReceivePullingScanInitial());

  void scanReceive() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var scan = pref.getString('scan');
    var shift = pref.getString('shift');
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      emit(ReceivePullingScanLoading());
      if (barcodeScanRes != '-1') {
        myRepository!.receiveScan(barcodeScanRes).then((value) {
          var json = jsonDecode(value.body);
          print('RECEIVE : $json');
          if (json['status'] == 'success') {
            emit(ReceivePullingScanLoaded(json: json, statusCode: 200));
          } else {
            emit(ReceivePullingScanLoaded(json: json, statusCode: 400));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}

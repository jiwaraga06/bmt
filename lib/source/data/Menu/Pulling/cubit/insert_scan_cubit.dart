import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'insert_scan_state.dart';

class InsertScanCubit extends Cubit<InsertScanState> {
  final MyRepository? myRepository;
  InsertScanCubit({required this.myRepository}) : super(InsertScanInitial());

  void scanInsert() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        emit(InsertScanLoading());
        myRepository!.pullingScanInsert(barcodeScanRes).then((value) {
          var json = jsonDecode(value.body);
          print('Insert Scan : $json');
          if (json['status'] == 'success') {
            emit(InsertScanLoaded(json: json, statusCode: 200));
          } else {
            emit(InsertScanLoaded(json: json, statusCode: 400));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void insertManual(value) async {
    emit(InsertScanLoading());
    myRepository!.pullingScanInsert(value).then((value) {
      var json = jsonDecode(value.body);
      print('Insert Scan : $json');
      if (json['status'] == 'success') {
        emit(InsertScanLoaded(json: json, statusCode: 200));
      } else {
        emit(InsertScanLoaded(json: json, statusCode: 400));
      }
    });
  }
}

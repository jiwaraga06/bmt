import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_packing_list_state.dart';

class DetailPackingListCubit extends Cubit<DetailPackingListState> {
  final MyRepository? myRepository;
  DetailPackingListCubit({required this.myRepository}) : super(DetailPackingListInitial());

  void scanDetail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var barcode = pref.getString('scan');
    var do_oid = pref.getString('do_oid');
    var so_oid = pref.getString('so_oid');
    var so_ptnr_id_sold = pref.getString('so_ptnr_id_sold');
    emit(DetailPackingListLoading());
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        var body = {
          'box_number': barcodeScanRes.toString(),
          'nik': barcode.toString(),
          'do_oid': do_oid.toString(),
          'so_oid': so_oid.toString(),
          'so_ptnr_id_sold': so_ptnr_id_sold.toString(),
        };
        print('BODY: $body');
        myRepository!.packingListDetailScan(body).then((value) {
          var json = jsonDecode(value.body);
          print('Result Packing List Detail: $json');
          if (json['status'] == 'success') {
            emit(DetailPackingListLoaded(json: json, statusCode: 200));
          } else {
            emit(DetailPackingListLoaded(json: json, statusCode: 400));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void clearDataDetailPacking() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    var body = {'usernik': nik};
    pref.remove('do_oid');
    pref.remove('so_oid');
    pref.remove('so_ptnr_id_sold');
    pref.remove('do_code');
    pref.remove('ptnr_name_sold');
    pref.remove('do_date');
    pref.remove('do_dlv_date');
    myRepository!.packingListDetailClear(body).then((value) {
      var statusCode = value.statusCode;
      print('DELETE DETAIL PACKING: $statusCode');
    });
  }
}

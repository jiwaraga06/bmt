import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'header_packing_list_state.dart';

class HeaderPackingListCubit extends Cubit<HeaderPackingListState> {
  final MyRepository? myRepository;
  HeaderPackingListCubit({required this.myRepository}) : super(HeaderPackingListInitial());

  void header() {
    print('header');
  }

  void getHeaderLoad() async {
    emit(HeaderPackingListLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var do_code = pref.getString('do_code');
    var ptnr_name_sold = pref.getString('ptnr_name_sold');
    var do_date = pref.getString('do_date');
    var do_dlv_date = pref.getString('do_dlv_date');

    // print('body: ${body['rows']}');
    if (do_code == null) {
      var body = {
        'rows': [
          {
            'do_code': '',
            'ptnr_name_sold': '',
            'do_date': '',
            'do_dlv_date': '',
          }
        ]
      };
      emit(HeaderPackingListLoaded(json: body, statusCode: 200));
    } else {
      var body = {
        'rows': [
          {
            'do_code': do_code,
            'ptnr_name_sold': ptnr_name_sold,
            'do_date': do_date,
            'do_dlv_date': do_dlv_date,
          }
        ]
      };
      emit(HeaderPackingListLoaded(json: body, statusCode: 200));
    }
  }

  void scanHeader() async {
    emit(HeaderPackingListLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      // print('Result Scan:  $barcodeScanRes');
      var replace = barcodeScanRes.replaceAll(RegExp('/'), '.');
      print('Result Scan:  $replace');
      if (barcodeScanRes != '-1') {
        myRepository!.packingListHeader(replace).then((value) {
          var json = jsonDecode(value.body);
          print('PACKING LIST HEADER: $json');
          if (json['status'] == 'success') {
            pref.setString('do_code', json['rows'][0]['do_code']);
            pref.setString('ptnr_name_sold', json['rows'][0]['ptnr_name_sold']);
            pref.setString('do_date', json['rows'][0]['do_date']);
            pref.setString('do_dlv_date', json['rows'][0]['do_dlv_date']);
            pref.setString('do_oid', json['rows'][0]['do_oid']);
            pref.setString('so_oid', json['rows'][0]['so_oid']);
            pref.setString('so_ptnr_id_sold', json['rows'][0]['so_ptnr_id_sold']);
            emit(HeaderPackingListLoaded(json: json, statusCode: 200));
          } else {
            emit(HeaderPackingListLoaded(json: json, statusCode: 400));
          }
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}

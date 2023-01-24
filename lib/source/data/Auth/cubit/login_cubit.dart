import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final MyRepository? myRepository;
  LoginCubit({required this.myRepository}) : super(LoginInitial());

  void login(valueShift, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      emit(LoginLoading());
      if (barcodeScanRes != '-1') {
        myRepository!.login(barcodeScanRes, valueShift).then((value) {
          var json = jsonDecode(value.body);
          emit(LoginLoaded(json: json));
          if (value.statusCode == 200) {
            pref.setString('username', json['username']);
            pref.setString('scan', barcodeScanRes);
            pref.setString('shift', valueShift);
            pref.setString('shiftname', json['shiftname']);
            Navigator.pushNamedAndRemoveUntil(context, BOTTOM_NAV_BAR, (route) => false);
          }
          print("JSON: ${json['username']}");
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}

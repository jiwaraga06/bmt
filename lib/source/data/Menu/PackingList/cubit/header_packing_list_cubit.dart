import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'header_packing_list_state.dart';

class HeaderPackingListCubit extends Cubit<HeaderPackingListState> {
  final MyRepository? myRepository;
  HeaderPackingListCubit({required this.myRepository}) : super(HeaderPackingListInitial());
  
  void header() {
    print('header');
  }

  void scanHeader() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {}
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}

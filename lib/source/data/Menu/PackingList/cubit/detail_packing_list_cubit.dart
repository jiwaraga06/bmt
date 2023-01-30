import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'detail_packing_list_state.dart';

class DetailPackingListCubit extends Cubit<DetailPackingListState> {
  final MyRepository? myRepository;
  DetailPackingListCubit({required this.myRepository}) : super(DetailPackingListInitial());

  void detail() {
    print('detail');
  }

  void scanDetail() async {
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

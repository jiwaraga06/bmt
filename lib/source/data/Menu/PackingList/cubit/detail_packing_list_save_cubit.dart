import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_packing_list_save_state.dart';

class DetailPackingListSaveCubit extends Cubit<DetailPackingListSaveState> {
  final MyRepository? myRepository;
  DetailPackingListSaveCubit({required this.myRepository}) : super(DetailPackingListSaveInitial());

  void detaiPackingListAddDetail(packld_seq, packld_pt_id, packl_ptnr_id, dod_oid, packld_code, packld_lot_no, packld_qty) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var do_oid = pref.getString('do_oid');
    var so_oid = pref.getString('so_oid');
    var so_ptnr_id_sold = pref.getString('so_ptnr_id_sold');
    var do_code = pref.getString('do_code');
    var ptnr_name_sold = pref.getString('ptnr_name_sold');
    var do_date = pref.getString('do_date');
    var do_dlv_date = pref.getString('do_dlv_date');
    var barcode = pref.getString('scan');
    var body = {
      'do_oid': do_oid,
      'so_oid': so_oid,
      'do_date': do_date,
      'do_dlv_date': do_dlv_date,
      'so_ptnr_id_sold': so_ptnr_id_sold,
      'packld_seq': packld_seq,
      'dod_oid': dod_oid,
      'packld_pt_id': packld_pt_id,
      'packl_ptnr_id': packl_ptnr_id,
      'packld_code': 'packld_code',
      'packld_lot_no': packld_lot_no,
      'packld_qty': packld_qty,
      'nik': barcode,
    };
    print(body);
    emit(DetailPackingListSaveLoading());
    myRepository!.packingListDetailAdd(body).then((value) {
      var json = jsonDecode(value.body);
      print('Result Add : $json');
      if (json['status'] == 'success') {
        emit(DetailPackingListSaveLoaded(json: json, statusCode: 200));
      } else {
        emit(DetailPackingListSaveLoaded(json: json, statusCode: 400));
      }
    });
  }
}

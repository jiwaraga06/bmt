import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_packing_get_state.dart';

class DetailPackingGetCubit extends Cubit<DetailPackingGetState> {
  final MyRepository? myRepository;
  DetailPackingGetCubit({required this.myRepository}) : super(DetailPackingGetInitial());

  void getDetailPackingList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    emit(DetailPackingGetLoading());
    myRepository!.packingListDetailGet(nik).then((value) {
      var json = jsonDecode(value.body);
      print('DETAIL LIST: $json');
      if (json['status'] == 'success') {
        emit(DetailPackingGetLoaded(json: json, statusCode: 200));
      } else {
        emit(DetailPackingGetLoaded(json: json, statusCode: 400));
      }
    });
  }
}

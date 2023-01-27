import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final MyRepository? myRepository;
  AccountCubit({required this.myRepository}) : super(AccountInitial());

  void getAccount() async {
    emit(AccountLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var scan = pref.getString('scan');
    var shift = pref.getString('shift');
    var shiftname = pref.getString('shiftname');
    var body = {
      "username": username.toString(),
      "scan": scan.toString(),
      "shift": shift.toString(),
      "shiftname": shiftname.toString(),
    };
    print(body);
    emit(AccountLoaded(json: body));
  }

  void logout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
  }
}

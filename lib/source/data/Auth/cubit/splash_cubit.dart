import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final MyRepository? myRepository;
  SplashCubit({required this.myRepository}) : super(SplashInitial());

  void session(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    await Future.delayed(const Duration(seconds: 1));
    if (username == null) {
      Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, BOTTOM_NAV_BAR, (route) => false);
    }
  }
}

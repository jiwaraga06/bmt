import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  static mySnackbar(context, message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
      duration: Duration(seconds: 2),
    );
  }

  static warningDialog(context, message) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Alert !',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }

  static successDialog(context, message, VoidCallback? btnOkPressed) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Success !',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkPressed,
    )..show();
  }

  static infoDialog(context, message) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Information !',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';

class MyAlertDialog {
  static warningDialog(context, message) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Alert !',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
  static successDialog(context, message) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Success !',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}

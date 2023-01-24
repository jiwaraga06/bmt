import 'package:bmt/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});

  Future getShift() async {
    var json = await myNetwork!.getShift();
    return json;
  }

  Future login(scan, value) async {
    var json = await myNetwork!.login(scan, value);
    return json;
  }

  Future getPulling(scan, tgl_awal, tgl_akhir) async {
    var json = await myNetwork!.getPulling(scan, tgl_awal, tgl_akhir);
    return json;
  }
}

import 'package:bmt/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});

  Future getShift() async {
    var json = await myNetwork!.getShift();
    return json;
  }
}

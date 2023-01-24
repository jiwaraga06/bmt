import 'package:bmt/source/network/api.dart';
import 'package:http/http.dart' as http;

class MyNetwork {
  Future getShift() async {
    try {
      var url = Uri.parse(MyApi.getShift());
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK GET SHIFT');
    }
  }

  Future login(scan, value) async {
    try {
      var url = Uri.parse(MyApi.login(scan, value));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK LOGIN');
    }
  }

  Future getPulling(scan,tgl_awal, tgl_akhir) async {
    try {
      var url = Uri.parse(MyApi.pulling(scan, tgl_awal, tgl_akhir));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK Pulling');
      
    }
  }

}

import 'package:bmt/source/network/api.dart';
import 'package:http/http.dart' as http;

class MyNetwork { 

  Future getShift()async {
    try {
      var url = Uri.parse(MyApi.getShift());
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK GET SHIFT');
    }
  }

}
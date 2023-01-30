import 'dart:convert';

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

  Future getPulling(scan, tgl_awal, tgl_akhir) async {
    try {
      var url = Uri.parse(MyApi.pulling(scan, tgl_awal, tgl_akhir));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK Pulling');
    }
  }

  Future pullingScanInsert(scan) async {
    try {
      var url = Uri.parse(MyApi.pullingScanInsert(scan));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK PULLING SCAN INSERT');
    }
  }

  Future pullingSave(body) async {
    try {
      var url = Uri.parse(MyApi.pullingSave());
      var response = await http.post(
        url,
        // headers: {'Accept': 'application/json'},
        body: body,
      );
      return response;
    } catch (e) {
      print('ERROR NETWORK PULLING SAVE');
    }
  }

  Future pullingskipwc(shift, nik, scan) async {
    try {
      var url = Uri.parse(MyApi.pullingskipwc(shift, nik, scan));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK PULLING SKIP WC');
    }
  }

  Future pullingunskipwc(shift, nik, scan) async {
    try {
      var url = Uri.parse(MyApi.pullingunskipwc(shift, nik, scan));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK PULLING UN SKIP WC');
    }
  }

  Future putawayScan(scan, nik, shift) async {
    try {
      var url = Uri.parse(MyApi.putawayScan(scan, nik, shift));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK SCAN PUTAWAY: $json');
    }
  }

  Future putaway(nik, tglAwal, tglAkhir) async {
    try {
      var url = Uri.parse(MyApi.putaway(nik, tglAwal, tglAkhir));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK PUTAWAY : $e');
    }
  }

  Future saveputaway(body) async {
    try {
      var url = Uri.parse(MyApi.putawaySave());
      var response = await http.post(url, body: body);
      return response;
    } catch (e) {
      print('ERROR NETWORK PUTAWAY SAVE: $e');
    }
  }

  Future putawayDetailSave(nik) async {
    try {
      var url = Uri.parse(MyApi.putawayDetailSave(nik));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK PUTAWAY DETAIL SAVE: $e');
    }
  }

  Future clearDetailSavePutAway(body) async {
    try {
      var url = Uri.parse(MyApi.clearDetailSavePutAway());
      var response = await http.post(url, body: body);
      return response;
    } catch (e) {
      print('ERROR NETWORK CLEAR DETAIL SAVE PUTAWAY: $e');
    }
  }

  Future saveDataPutAway(body) async {
    try {
      var url = Uri.parse(MyApi.saveDataPutAway());
      var response = await http.post(url, body: body);
      return response;
    } catch (e) {
      print('ERROR NETWORK SAVE DATA PUTAWAY: $e');
    }
  }

  // PACKING LIST
  Future getPackingList(nik, tanggalAwal, tanggalAkhir) async {
    try {
      var url = Uri.parse(MyApi.getPackingList(nik, tanggalAwal, tanggalAkhir));
      var response = await http.get(url);
      return response;
    } catch (e) {
      print('ERROR NETWORK GET PACKING LIST: $e');
    }
  }
}

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

  Future pullingScanInsert(scan) async {
    var json = await myNetwork!.pullingScanInsert(scan);
    return json;
  }

  Future pullingSave(body) async {
    var json = await myNetwork!.pullingSave(body);
    return json;
  }

  Future pullingskipwc(shift, nik, scan) async {
    var json = await myNetwork!.pullingskipwc(shift, nik, scan);
    return json;
  }

  Future pullingunskipwc(shift, nik, scan) async {
    var json = await myNetwork!.pullingunskipwc(shift, nik, scan);
    return json;
  }

  Future putawayScan(scan, nik, shift) async {
    var json = await myNetwork!.putawayScan(scan, nik, shift);
    return json;
  }

  Future putaway(nik, tglAwal, tglAkhir) async {
    var json = await myNetwork!.putaway(nik, tglAwal, tglAkhir);
    return json;
  }

  Future qrPutaway(gambar) async {
    var json = await myNetwork!.qrPutAwayPrint(gambar);
    return json;
  }

  Future saveputaway(body) async {
    var json = await myNetwork!.saveputaway(body);
    return json;
  }

  Future deletePutAway(body) async {
    var json = await myNetwork!.deletePutAway(body);
    return json;
  }

  Future putawayDetailSave(nik) async {
    var json = await myNetwork!.putawayDetailSave(nik);
    return json;
  }

  Future putawayPrint(packld_oid) async {
    var json = await myNetwork!.putawayPrint(packld_oid);
    return json;
  }

  Future clearDetailSavePutAway(body) async {
    var json = await myNetwork!.clearDetailSavePutAway(body);
    return json;
  }

  Future saveDataPutAway(body) async {
    var json = await myNetwork!.saveDataPutAway(body);
    return json;
  }

  // PACKING LIST
  Future getPackingList(nik, tanggalAwal, tanggalAkhir) async {
    var json = await myNetwork!.getPackingList(nik, tanggalAwal, tanggalAkhir);
    return json;
  }

  Future packingListHeader(scan) async {
    var json = await myNetwork!.packingListHeader(scan);
    return json;
  }

  Future packingListDetailScan(body) async {
    var json = await myNetwork!.packingListDetailScan(body);
    return json;
  }

  Future packingListDetailAdd(body) async {
    var json = await myNetwork!.packingListDetailAdd(body);
    return json;
  }

  Future packingListDetailGet(nik) async {
    var json = await myNetwork!.packingListDetailGet(nik);
    return json;
  }

  Future packingListDetailSave(body) async {
    var json = await myNetwork!.packingListDetailSave(body);
    return json;
  }

  Future packingListDetailClear(body) async {
    var json = await myNetwork!.packingListDetailClear(body);
    return json;
  }
}

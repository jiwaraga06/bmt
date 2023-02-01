String baseUrl = 'http://182.253.45.29:88/api-dev04/';

class MyApi {
  static getShift() {
    return '$baseUrl/get_function/shift';
  }

  static login(scan, value) {
    return '$baseUrl/login/scan/$scan/$value';
  }

  static pulling(scan, tgl_awal, tgl_akhir) {
    return '$baseUrl/pages/dashboard/get/$scan/$tgl_awal/$tgl_akhir';
  }

  static pullingScanInsert(scan) {
    return '$baseUrl/pages/pooling/scan/$scan';
  }

  static pullingSave() {
    return '$baseUrl/pages/pooling/save';
  }

  static pullingskipwc(shift, nik, scan) {
    return '$baseUrl/pages/pooling/skip/$shift/$nik/$scan';
  }

  static pullingunskipwc(shift, nik, scan) {
    return '$baseUrl/pages/pooling/unskip/$shift/$nik/$scan';
  }

  static putaway(nik, tglAwal, tglAkhir) {
    return '$baseUrl/pages/packing_list/get/$nik/$tglAwal/$tglAkhir';
  }

  static putawayScan(scan, nik, shift) {
    return '$baseUrl/pages/packing_list/scan_detail/$scan/$nik/$shift';
  }

  static putawaySave() {
    return '$baseUrl/pages/packing_list/add_detail';
  }

  static putawayDetailSave(nik) {
    return '$baseUrl/pages/packing_list/get_detail/$nik';
  }

  static putawayDelete() {
    return '$baseUrl/pages/packing_list/delete_data';
  }

  static putawayPrint(packld_oid) {
    return '$baseUrl/pages/packing_list/print/$packld_oid';
  }

  static qrPutAwayPrint(gambar) {
    return '$baseUrl/assets/images/$gambar';
  }

  static clearDetailSavePutAway() {
    return '$baseUrl/pages/packing_list/clear_detail';
  }

  static saveDataPutAway() {
    return '$baseUrl/pages/packing_list/save_data';
  }

  // PACKING LIST
  static getPackingList(nik, tanggalAwal, tanggalAkhir) {
    return '$baseUrl/pages/packing_list_v2/get/$nik/$tanggalAwal/$tanggalAkhir';
  }

  static packingListHeader(scan) {
    return '$baseUrl/pages/packing_list_v2/scan/$scan';
  }

  static packingListDetailScan() {
    return '$baseUrl/pages/packing_list_v2/scan_detail/';
  }

  static packingListDetailAdd() {
    return '$baseUrl/pages/packing_list_v2/add_detail';
  }

  static packingListDetailGet(nik) {
    return '$baseUrl/pages/packing_list_v2/get_detail/$nik';
  }
  static packingListDetailSave() {
    return '$baseUrl/pages/packing_list_v2/save_data';
  }

  static packingListDetailClear() {
    return '$baseUrl/pages/packing_list_v2/clear_detail';
  }
}

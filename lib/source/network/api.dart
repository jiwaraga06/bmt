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

  static pullingSave(){
    return '$baseUrl/pages/pooling/save';
  }

}

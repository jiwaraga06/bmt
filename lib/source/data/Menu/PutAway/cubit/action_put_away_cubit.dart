import 'dart:convert';
import 'package:bmt/source/network/api.dart';
import 'package:bmt/source/pages/Menu/PutAway/pdfView.dart';
import 'package:pdf/pdf.dart';
import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'action_put_away_state.dart';

class ActionPutAwayCubit extends Cubit<ActionPutAwayState> {
  final MyRepository? myRepository;
  ActionPutAwayCubit({required this.myRepository}) : super(ActionPutAwayInitial());

  void deletePutAway(packld_oid) async {
    emit(ActionDeletePutAwayLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var nik = pref.getString('scan');
    var body = {
      'nik': nik,
      'oid': packld_oid,
    };
    print(body);
    myRepository!.deletePutAway(body).then((value) {
      var json = jsonDecode(value.body);
      print('DELETE PUT AWAY: $json');
      if (json['status'] != 'error') {
        emit(ActionDeletePutAwayLoaded(statusCode: 200, json: json));
      } else {
        emit(ActionDeletePutAwayLoaded(statusCode: 400, json: json));
      }
    });
  }

  void printPutaway(packld_oid) async {
    print(packld_oid);
    emit(ActionPrintPutAwayLoading());
    myRepository!.putawayPrint(packld_oid).then((value) async {
      var json = jsonDecode(value.body);
      print('PRINT: $json');
      if (value.statusCode == 200) {
        emit(ActionPrintPutAwayLoaded(json: json, statusCode: value.statusCode));
        var html = json['html'];
        print('QR:  ${json['qrcode']}');
        print('QR: http://182.253.45.29:88/api-dev04/assets/images/${json['qrcode']}.png');
        var imageSoure = "http://182.253.45.29:88/api-dev04/assets/images/TDI001-230127-1-003.png";
        myRepository!.qrPutaway('${json['qrcode']}.png').then((value) async {
          var result = value.body;
          print(result);

          try {
            await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
                      format: format,
                      html: PDFView.htmlContent(html, imageSoure),
                    ));
            // print('Result print: $result');
          } catch (e) {
            print('Error print: $e');
          }
        });
      } else {
        emit(ActionPrintPutAwayLoaded(json: json, statusCode: value.statusCode));
      }
    });
  }
}

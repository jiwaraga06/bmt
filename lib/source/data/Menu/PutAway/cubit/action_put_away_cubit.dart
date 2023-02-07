import 'dart:convert';
import 'package:bmt/source/network/api.dart';
import 'package:bmt/source/pages/Menu/PutAway/pdfView.dart';
import 'package:flutter/animation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;

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

  void printPutaway(packld_oid, context) async {
    final doc = pw.Document();
    print(packld_oid);
    emit(ActionPrintPutAwayLoading());
    myRepository!.putawayPrint(packld_oid).then((value) async {
      var json = jsonDecode(value.body);
      print('PRINT: $json');
      if (value.statusCode == 200) {
        emit(ActionPrintPutAwayLoaded(json: json, statusCode: value.statusCode));
        print('QR:  ${json['qrcode']}');
        print('QR: http://182.253.45.29:88/api-dev04/assets/images/${json['qrcode']}.png');
        final netImage = await networkImage('http://182.253.45.29:88/api-dev04/assets/images/${json['qrcode']}.png');
        doc.addPage(pw.Page(
          build: (context) {
            return pw.Container(
                child: pw.Column(children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Text(json['entitas'], style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 15),
                  pw.Text('O.K. PART', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                ]),
                pw.Container(
                    height: 50,
                    width: 90,
                    color: PdfColors.black,
                    // color: Color.fromARGB(0, 35, 35, 35),
                    alignment: pw.Alignment.center,
                    child: pw.Text(json['model'], style: pw.TextStyle(fontSize: 22, color: PdfColors.white, fontWeight: pw.FontWeight.bold)))
              ]),
              pw.SizedBox(height: 4),
              pw.Divider(thickness: 2, color: PdfColors.grey),
              pw.SizedBox(height: 4),
              pw.Table(columnWidths: const {
                0: pw.FixedColumnWidth(90),
                1: pw.FixedColumnWidth(10),
              }, children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('Model', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text(json['model'], style: pw.TextStyle(fontSize: 17)),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('Nama Part', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text(json['nama_part'], style: pw.TextStyle(fontSize: 17)),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('Nomor Part', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text(json['no_part'], style: pw.TextStyle(fontSize: 17)),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('Customer', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text(json['customer'], style: pw.TextStyle(fontSize: 17)),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('No Lot', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text(json['no_lot'], style: pw.TextStyle(fontSize: 17)),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('Qty(Pcs)', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text(json['qty'], style: pw.TextStyle(fontSize: 17)),
                ]),
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text('Tgl Kirim', style: pw.TextStyle(fontSize: 17)),
                  ),
                  pw.Text(':', style: pw.TextStyle(fontSize: 17)),
                  pw.Text('', style: pw.TextStyle(fontSize: 17)),
                ]),
              ]),
              pw.SizedBox(height: 20),
              pw.Table(
                  // border: pw.TableBorder.symmetric(
                  //   outside: pw.BorderSide(width: 2, color: PdfColors.black),
                  // ),
                  border: pw.TableBorder.all(
                    width: 2,
                    color: PdfColors.black,
                  ),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8.0),
                        child: pw.Center(
                          child: pw.Image(netImage, height: 80),
                        ),
                      ),
                      pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(bottom: -8),
                          child: pw.Text('QC', textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Divider(thickness: 2, color: PdfColors.black),
                      ]),
                      pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(bottom: -8),
                          child: pw.Text('PPIC', textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Divider(thickness: 2, color: PdfColors.black),
                      ]),
                    ]),
                  ])
            ]));
          },
        ));
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
      } else {
        emit(ActionPrintPutAwayLoaded(json: json, statusCode: value.statusCode));
      }
    });
  }
}

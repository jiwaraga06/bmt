import 'package:bmt/source/data/Menu/PutAway/cubit/detail_save_putaway_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/insert_put_away_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/putaway_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/save_put_away_cubit.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customBtnScanQr.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:bmt/source/widget/customTextFieldRead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InsertPutAway extends StatefulWidget {
  const InsertPutAway({super.key});

  @override
  State<InsertPutAway> createState() => _InsertPutAwayState();
}

class _InsertPutAwayState extends State<InsertPutAway> {
  TextEditingController controllerCust = TextEditingController();
  TextEditingController controllerBoxNum = TextEditingController();
  TextEditingController controllerLot = TextEditingController();
  TextEditingController controllerQtyAvailable = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? customer_id, wo_oid, wop_pt_id, invp_wopl_oid, wopl_code_box;

  save() {
    // if (formKey.currentState!.validate()) {
    Navigator.pop(context);
    BlocProvider.of<SavePutAwayCubit>(context).savePutAway(
      controllerQty.text,
      wo_oid,
      controllerQtyAvailable.text,
      controllerBoxNum.text,
      controllerLot.text,
      invp_wopl_oid,
      wopl_code_box,
      customer_id,
      controllerCust.text,
      wop_pt_id,
    );
    // }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailSavePutawayCubit>(context).getDetailSavePutAway();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Kembali');
        BlocProvider.of<DetailSavePutawayCubit>(context).clearDetailSavePutAway();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Insert Put Away'),
          leading: IconButton(
              onPressed: () {
                print('Kembali');
                Navigator.pop(context);
                BlocProvider.of<DetailSavePutawayCubit>(context).clearDetailSavePutAway();
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            BlocListener<DetailSavePutawayCubit, DetailSavePutawayState>(
              listener: (context, state) {
                if (state is SaveDataPutawayLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return const CustomLoading();
                    },
                  );
                }
                if (state is SaveDataPutawayLoaded) {
                  Navigator.pop(context);
                  var json = state.json;
                  var statusCode = state.statusCode;
                  if (statusCode == 200) {
                    MyAlertDialog.successDialog(
                      context,
                      json['msg'],
                      () {
                        Navigator.pop(context);
                        BlocProvider.of<PutawayCubit>(context).currentPutaway();
                      },
                    );
                  } else {
                    MyAlertDialog.warningDialog(context, json['msg']);
                  }
                }
              },
              child: TextButton(
                  onPressed: () {
                    BlocProvider.of<DetailSavePutawayCubit>(context).saveDataPutAway();
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<SavePutAwayCubit, SavePutAwayState>(
                listener: (context, state) {
                  if (state is SavePutAwayLoading) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CustomLoading();
                      },
                    );
                  }
                  if (state is SavePutAwayLoaded) {
                    Navigator.pop(context);
                    var statusCode = state.statusCode;
                    var json = state.json;
                    if (statusCode == 200) {
                      BlocProvider.of<DetailSavePutawayCubit>(context).getDetailSavePutAway();
                    } else {
                      MyAlertDialog.warningDialog(context, json['msg']);
                    }
                  }
                },
                child: BlocListener<InsertPutAwayCubit, InsertPutAwayState>(
                  listener: (context, state) {
                    if (state is InsertPutAwayLoading) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return const CustomLoading();
                        },
                      );
                    }
                    if (state is InsertPutAwayLoaded) {
                      Navigator.pop(context);
                      var statusCode = state.statusCode;
                      var json = state.json;
                      if (statusCode == 200) {
                        setState(() {
                          controllerCust = TextEditingController(text: json['customer']);
                          controllerBoxNum = TextEditingController(text: json['rows'][0]['wopl_code']);
                          controllerLot = TextEditingController(text: json['rows'][0]['lot_serial']);
                          controllerQtyAvailable = TextEditingController(text: json['rows'][0]['invp_qty']);
                          customer_id = json['customer_id'];
                          wop_pt_id = json['rows'][0]['wop_pt_id'];
                          invp_wopl_oid = json['rows'][0]['invp_wopl_oid'];
                          wo_oid = json['rows'][0]['wo_oid'];
                          wopl_code_box = json['rows'][0]['wopl_code'];
                        });
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            // padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'TUTUP',
                                          style: TextStyle(color: Colors.red[700], fontSize: 16),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          save();
                                          controllerBoxNum.clear();
                                          controllerCust.clear();
                                          controllerLot.clear();
                                          controllerQty.clear();
                                          controllerQtyAvailable.clear();
                                        },
                                        child: Text(
                                          'ADD DETAIL',
                                          style: TextStyle(color: Colors.blue[700], fontSize: 16),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        CustomFormFieldRead(
                                          controller: controllerCust,
                                          label: 'Customer',
                                          msgError: 'Kolom ini harus di isi',
                                        ),
                                        CustomFormFieldRead(
                                          controller: controllerBoxNum,
                                          label: 'Box Number',
                                          msgError: 'Kolom ini harus di isi',
                                        ),
                                        CustomFormFieldRead(
                                          controller: controllerLot,
                                          label: 'Lot Serial',
                                          msgError: 'Kolom ini harus di isi',
                                        ),
                                        CustomFormField(
                                          controller: controllerQtyAvailable,
                                          label: 'Qty Available',
                                          msgError: 'Kolom ini harus di isi',
                                          inputType: TextInputType.number,
                                        ),
                                        CustomFormField(
                                          controller: controllerQty,
                                          label: 'Qty',
                                          msgError: 'Kolom ini harus di isi',
                                          inputType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        MyAlertDialog.warningDialog(context, json.toString());
                      }
                    }
                  },
                  child: CustomButtonScanQR(
                    onTap: () {
                      BlocProvider.of<InsertPutAwayCubit>(context).scan();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<DetailSavePutawayCubit, DetailSavePutawayState>(
                builder: (context, state) {
                  if (state is DetailSavePutawayLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is DetailSavePutawayLoaded == false) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                  var json = (state as DetailSavePutawayLoaded).json;
                  var statusCode = (state as DetailSavePutawayLoaded).statusCode;
                  if (json['rows'].isEmpty) {
                    return const Center(
                      child: Text('Data Kosong'),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: json['rows'].length,
                      itemBuilder: (context, index) {
                        var data = json['rows'][index];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1.2,
                              blurRadius: 1.2,
                              offset: Offset(1, 2),
                            )
                          ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(data['pckm_customer_name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text('${data['pckm_wopl_code']}', style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 8.0),
                              Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(90),
                                  1: FixedColumnWidth(10),
                                },
                                children: [
                                  TableRow(children: [
                                    Text('Lot Number', style: TextStyle(fontSize: 15)),
                                    Text(':', style: TextStyle(fontSize: 15)),
                                    Text(data['pckm_lot'], style: TextStyle(fontSize: 15)),
                                  ]),
                                  TableRow(children: [
                                    Text('Qty', style: TextStyle(fontSize: 15)),
                                    Text(':', style: TextStyle(fontSize: 15)),
                                    Text(data['pckm_qty'], style: TextStyle(fontSize: 15)),
                                  ]),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_get_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_save_cubit.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customBtnScanQr.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:bmt/source/widget/customTextFieldRead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DetailPackingList extends StatefulWidget {
  const DetailPackingList({super.key});

  @override
  State<DetailPackingList> createState() => _DetailPackingListState();
}

class _DetailPackingListState extends State<DetailPackingList> {
  TextEditingController controllerBoxNum = TextEditingController();
  TextEditingController controllerlot = TextEditingController();
  TextEditingController controllerPartNum = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  var packld_seq, packld_pt_id, packl_ptnr_id, dod_oid;
  void save() {
    BlocProvider.of<DetailPackingListSaveCubit>(context).detaiPackingListAddDetail(
      packld_seq,
      packld_pt_id,
      packl_ptnr_id,
      dod_oid,
      controllerBoxNum.text,
      controllerlot.text,
      controllerQty.text,
    );
    Navigator.pop(context);
    BlocProvider.of<DetailPackingGetCubit>(context).getDetailPackingList();
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 12.0),
            child: BlocListener<DetailPackingListSaveCubit, DetailPackingListSaveState>(
              listener: (context, state) {
                if (state is DetailPackingListSaveLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const CustomLoading();
                    },
                  );
                }
                if (state is DetailPackingListSaveLoaded) {
                  Navigator.pop(context);
                  var json = state.json;
                  var statusCode = state.statusCode;
                  if (statusCode != 200) {
                    MyAlertDialog.warningDialog(context, json['msg']);
                  }
                }
              },
              child: BlocListener<DetailPackingListCubit, DetailPackingListState>(
                listener: (context, state) {
                  if (state is DetailPackingListLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const CustomLoading();
                      },
                    );
                  }
                  if (state is DetailPackingListLoaded) {
                    Navigator.pop(context);
                    var statusCode = state.statusCode;
                    var json = state.json;
                    if (statusCode == 200) {
                      setState(() {
                        packld_seq = json['rows'][0]['packld_seq'];
                        packld_pt_id = json['rows'][0]['packld_pt_id'];
                        packl_ptnr_id = json['rows'][0]['packl_ptnr_id'];
                        dod_oid = json['dod_oid'];
                        controllerBoxNum = TextEditingController(text: json['rows'][0]['packld_code']);
                        controllerlot = TextEditingController(text: json['rows'][0]['packld_lot_no']);
                        controllerPartNum = TextEditingController(text: json['rows'][0]['pt_code']);
                        controllerQty = TextEditingController(text: json['rows'][0]['packld_qty']);
                      });
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
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
                                          controllerlot.clear();
                                          controllerPartNum.clear();
                                          controllerQty.clear();
                                        },
                                        child: Text(
                                          'ADD DETAIL',
                                          style: TextStyle(color: Colors.blue[700], fontSize: 16),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomFormFieldRead(
                                        controller: controllerBoxNum,
                                        label: 'Box Customer',
                                      ),
                                      CustomFormFieldRead(
                                        controller: controllerlot,
                                        label: 'Lot Serial',
                                      ),
                                      CustomFormFieldRead(
                                        controller: controllerPartNum,
                                        label: 'Part Number',
                                      ),
                                      CustomFormField(
                                        inputType: TextInputType.number,
                                        controller: controllerQty,
                                        label: 'Quantity',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      MyAlertDialog.warningDialog(context, json['msg']);
                    }
                  }
                },
                child: CustomButtonScanQR(
                  onTap: () {
                    BlocProvider.of<DetailPackingListCubit>(context).scanDetail();
                  },
                  text: 'Scan Box Customer',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<DetailPackingGetCubit, DetailPackingGetState>(
              builder: (context, state) {
                if (state is DetailPackingGetLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DetailPackingGetLoaded == false) {
                  return const Center();
                }
                var json = (state as DetailPackingGetLoaded).json;
                if (json['rows'].isEmpty) {
                  return const Center(
                    child: Text('Data Kosong'),
                  );
                }
                return Container(
                  child: ListView.builder(
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
                            Table(
                              columnWidths: const {
                                0: FixedColumnWidth(90),
                                1: FixedColumnWidth(10),
                              },
                              children: [
                                TableRow(children: [
                                  Text('Box Customer', style: TextStyle(fontSize: 15)),
                                  Text(':', style: TextStyle(fontSize: 15)),
                                  Text(data['dodet_packld_code'], style: TextStyle(fontSize: 15)),
                                ]),
                                TableRow(children: [
                                  Text('Lot Serial', style: TextStyle(fontSize: 15)),
                                  Text(':', style: TextStyle(fontSize: 15)),
                                  Text(data['dodet_packld_lot_no'], style: TextStyle(fontSize: 15)),
                                ]),
                                TableRow(children: [
                                  Text('Part Number', style: TextStyle(fontSize: 15)),
                                  Text(':', style: TextStyle(fontSize: 15)),
                                  Text(data['pt_code'], style: TextStyle(fontSize: 15)),
                                ]),
                                TableRow(children: [
                                  Text('Quantity', style: TextStyle(fontSize: 15)),
                                  Text(':', style: TextStyle(fontSize: 15)),
                                  Text(data['dodet_packld_qty'], style: TextStyle(fontSize: 15)),
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
          ),
        ],
      ),
    );
  }
}

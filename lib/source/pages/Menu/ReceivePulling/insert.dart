import 'package:bmt/source/data/Menu/ReceivePulling/cubit/receive_pulling_cubit.dart';
import 'package:bmt/source/data/Menu/ReceivePulling/cubit/receive_pulling_insert_cubit.dart';
import 'package:bmt/source/data/Menu/ReceivePulling/cubit/receive_pulling_scan_cubit.dart';
import 'package:bmt/source/data/Menu/ReceivePulling/cubit/receive_pulling_wc_cubit.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customBtnScanQr.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:bmt/source/widget/customTextFieldRead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InsertReceivePulling extends StatefulWidget {
  const InsertReceivePulling({super.key});

  @override
  State<InsertReceivePulling> createState() => _InsertReceivePullingState();
}

class _InsertReceivePullingState extends State<InsertReceivePulling> {
  TextEditingController controllerWo = TextEditingController();
  TextEditingController controllerBoxNum = TextEditingController();
  TextEditingController controllerWorkCenterValue = TextEditingController();
  TextEditingController controllerQtyReceive = TextEditingController();
  TextEditingController controllerQtyRepair = TextEditingController();
  TextEditingController controllerQtyReNG = TextEditingController();
  var wopl_oid, work_center;
  final formKey = GlobalKey<FormState>();

  void save() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<ReceivePullingInsertCubit>(context).saveReceivePulling(
        controllerBoxNum.text,
        controllerQtyReceive.text,
        controllerQtyRepair.text,
        controllerQtyReNG.text,
        work_center,
        controllerWo.text,
        wopl_oid,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReceivePullingWcCubit>(context).getReceiveWorkCenter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Receive Pulling'),
        actions: [
          TextButton(
            onPressed: () {
              save();
            },
            child: Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: BlocListener<ReceivePullingInsertCubit, ReceivePullingInsertState>(
        listener: (context, state) {
          if (state is ReceivePullingInsertLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const CustomLoading(),
            );
          }
          if (state is ReceivePullingInsertLoaded) {
            Navigator.pop(context);
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              MyAlertDialog.successDialog(context, json['msg'], () {
                BlocProvider.of<ReceivePullingCubit>(context).recevieGetCurrent();
                Navigator.pop(context);
              });
            } else if (statusCode == 400) {
              MyAlertDialog.warningDialog(context, json['msg']);
            }
          }
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonScanQR(
                onTap: () {
                  BlocProvider.of<ReceivePullingScanCubit>(context).scanReceive();
                },
                text: 'Scan QR COde',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<ReceivePullingScanCubit, ReceivePullingScanState>(
                listener: (context, state) {
                  if (state is ReceivePullingScanLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const CustomLoading(),
                    );
                  }
                  if (state is ReceivePullingScanLoaded) {
                    Navigator.pop(context);
                    var json = state.json;
                    var statusCode = state.statusCode;
                    setState(() {
                      controllerBoxNum = TextEditingController(text: json['rows'][0]['box_number']);
                      controllerWo = TextEditingController(text: json['rows'][0]['wo_code']);
                      controllerQtyReceive = TextEditingController(text: json['rows'][0]['qty_receive'].toString());
                      wopl_oid = json['rows'][0]['wopl_oid'];
                    });
                  }
                },
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormFieldRead(
                        controller: controllerWo,
                        label: 'Work Order',
                        // msgError: 'Kolom harus di isi',
                      ),
                      const SizedBox(height: 8.0),
                      CustomFormFieldRead(
                        controller: controllerBoxNum,
                        label: 'Box Number',
                        // msgError: 'Kolom harus di isi',
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: controllerWorkCenterValue,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom harus di isi';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Work Center',
                            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            suffixIcon: Icon(Icons.arrow_drop_down_outlined)),
                        onTap: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            enableDrag: true,
                            builder: (context) {
                              return BlocBuilder<ReceivePullingWcCubit, ReceivePullingWcState>(
                                builder: (context, state) {
                                  if (state is ReceivePullingWcLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is ReceivePullingWcLoaded == false) {
                                    return const Center(child: Text('Data False'));
                                  }
                                  var json = (state as ReceivePullingWcLoaded).json;
                                  return Column(
                                    children: [
                                      const SizedBox(height: 30.0),
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
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Cari Work Center',
                                            prefixIcon: Icon(Icons.search),
                                          ),
                                          onChanged: (value) {
                                            BlocProvider.of<ReceivePullingWcCubit>(context).getReceiveWorkCenterSearch(value);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: json.length,
                                          itemBuilder: (context, index) {
                                            var data = json[index];
                                            return ListTile(
                                              leading: work_center == data['value']
                                                  ? Icon(Icons.circle, color: Colors.blue)
                                                  : Icon(Icons.circle_outlined, color: Colors.blue),
                                              onTap: () {
                                                print(data);
                                                setState(() {
                                                  controllerWorkCenterValue = TextEditingController(text: data['display']);
                                                  work_center = data['value'];
                                                  Navigator.pop(context);
                                                });
                                              },
                                              title: Text(data['display']),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      CustomFormField(
                        inputType: TextInputType.number,
                        controller: controllerQtyReceive,
                        label: 'Qty Receive',
                        msgError: 'Kolom harus di isi',
                      ),
                      const SizedBox(height: 8.0),
                      CustomFormField(
                        inputType: TextInputType.number,
                        controller: controllerQtyRepair,
                        label: 'Qty Repair',
                        // msgError: 'Kolom harus di isi',
                      ),
                      const SizedBox(height: 8.0),
                      CustomFormField(
                        inputType: TextInputType.number,
                        controller: controllerQtyReNG,
                        label: 'Qty NG',
                        // msgError: 'Kolom harus di isi',
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

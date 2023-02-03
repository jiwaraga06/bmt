import 'package:bmt/source/data/Menu/ReceivePulling/cubit/receive_pulling_wc_cubit.dart';
import 'package:bmt/source/widget/customBtnScanQr.dart';
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
  var wopl_oid;
  final formKey = GlobalKey<FormState>();

  void save() {}

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
          TextButton(onPressed: () {}, child: Text('SAVE', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButtonScanQR(text: 'Scan QR COde'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomFormFieldRead(
                    controller: controllerWo,
                    label: 'Work Order',
                    msgError: 'Kolom harus di isi',
                  ),
                  const SizedBox(height: 8.0),
                  CustomFormFieldRead(
                    controller: controllerBoxNum,
                    label: 'Box Number',
                    msgError: 'Kolom harus di isi',
                  ),
                  const SizedBox(height: 8.0),
                  CustomFormFieldRead(
                    controller: controllerWorkCenterValue,
                    label: 'Pilih Work Center',
                    msgError: 'Kolom harus di isi',
                    onTap: () {
                      print('object');
                      showMaterialModalBottomSheet(
                        context: context,
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
                              if (json.isEmpty) {
                                return const Center(child: Text('Data Kosong'));
                              }
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: json.length,
                                      itemBuilder: (context, index) {
                                        var data = json[index];
                                        return ListTile(
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
                  CustomFormFieldRead(
                    controller: controllerQtyReceive,
                    label: 'Qty Receive',
                    msgError: 'Kolom harus di isi',
                  ),
                  const SizedBox(height: 8.0),
                  CustomFormFieldRead(
                    controller: controllerQtyRepair,
                    label: 'Qty Repair',
                    msgError: 'Kolom harus di isi',
                  ),
                  const SizedBox(height: 8.0),
                  CustomFormFieldRead(
                    controller: controllerQtyReNG,
                    label: 'Qty NG',
                    msgError: 'Kolom harus di isi',
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

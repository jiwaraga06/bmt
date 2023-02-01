import 'dart:async';

import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_load_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/header_packing_list_cubit.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customBtnScanQr.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:bmt/source/widget/customTextFieldRead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderPackingList extends StatefulWidget {
  const HeaderPackingList({super.key});

  @override
  State<HeaderPackingList> createState() => _HeaderPackingListState();
}

class _HeaderPackingListState extends State<HeaderPackingList> {
  TextEditingController controllerDoNumber = TextEditingController();
  TextEditingController controllerSoldTo = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerDeliveryDate = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      BlocProvider.of<HeaderPackingListCubit>(context).getHeaderLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HeaderPackingListCubit, HeaderPackingListState>(
        listener: (context, state) {
          if (state is HeaderPackingListLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const CustomLoading();
              },
            );
          }
          if (state is HeaderPackingListLoaded) {
            Navigator.pop(context);
            var statusCode = state.statusCode;
            var json = state.json;
            if (statusCode != 200) {
              MyAlertDialog.warningDialog(context, json['msg']);
            } else {
              setState(() {
                controllerDoNumber = TextEditingController(text: json['rows'][0]['do_code']);
                controllerSoldTo = TextEditingController(text: json['rows'][0]['ptnr_name_sold']);
                controllerDate = TextEditingController(text: json['rows'][0]['do_date']);
                controllerDeliveryDate = TextEditingController(text: json['rows'][0]['do_dlv_date']);
              });
            }
          }
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 12.0),
              child: CustomButtonScanQR(
                onTap: () {
                  BlocProvider.of<HeaderPackingListCubit>(context).scanHeader();
                },
                text: 'Scan Delivery Order',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomFormFieldRead(
                        controller: controllerDoNumber,
                        label: 'Do Number',
                      ),
                      const SizedBox(height: 4),
                      CustomFormFieldRead(
                        controller: controllerSoldTo,
                        label: 'Sold To',
                      ),
                      const SizedBox(height: 4),
                      CustomFormFieldRead(
                        controller: controllerDate,
                        label: 'Date',
                      ),
                      const SizedBox(height: 4),
                      CustomFormFieldRead(
                        controller: controllerDeliveryDate,
                        label: 'Delivery Date',
                      ),
                      const SizedBox(height: 4),
                      CustomFormFieldRead(
                        controller: controllerRemarks,
                        label: 'Remarks',
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bmt/source/widget/customBtnScanQr.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 12.0),
            child: CustomButtonScanQR(
              onTap: () {},
              text: 'Scan Delivery Order',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: controllerDoNumber,
                      label: 'Do Number',
                    ),
                    const SizedBox(height: 4),
                    CustomFormField(
                      controller: controllerSoldTo,
                      label: 'Sold To',
                    ),
                    const SizedBox(height: 4),
                    CustomFormField(
                      controller: controllerDate,
                      label: 'Date',
                    ),
                    const SizedBox(height: 4),
                    CustomFormField(
                      controller: controllerDeliveryDate,
                      label: 'Delivery Date',
                    ),
                    const SizedBox(height: 4),
                    CustomFormField(
                      controller: controllerRemarks,
                      label: 'Remarks',
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

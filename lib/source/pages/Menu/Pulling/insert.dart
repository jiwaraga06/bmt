import 'package:bmt/source/widget/customBtnSave.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:bmt/source/widget/customTextFieldRead.dart';
import 'package:flutter/material.dart';

class InsertPulling extends StatefulWidget {
  const InsertPulling({super.key});

  @override
  State<InsertPulling> createState() => _InsertPullingState();
}

class _InsertPullingState extends State<InsertPulling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Pulling'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    CustomFormFieldRead(
                      label: 'Work Order',
                    ),
                    CustomFormFieldRead(
                      label: 'Box Number',
                    ),
                    CustomFormFieldRead(
                      label: 'Work Center From',
                    ),
                    CustomFormFieldRead(
                      label: 'Work Center To',
                    ),
                    CustomFormField(
                      label: 'Quantity OK',
                      inputType: TextInputType.number,
                    ),
                    CustomFormField(
                      label: 'Quantity Repair',
                      inputType: TextInputType.number,
                    ),
                    CustomFormField(
                      label: 'Quantity NG',
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 50,
                    child: CustomButtonSave(
                      onPressed: (){},
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

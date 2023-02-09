import 'package:bmt/source/data/Auth/cubit/login_cubit.dart';
import 'package:bmt/source/data/Auth/cubit/shift_cubit.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? dropdownvalue;

  void login() {
    if (dropdownvalue != null) {
      BlocProvider.of<LoginCubit>(context).login(dropdownvalue, context);
    } else {
      MyAlertDialog.warningDialog(context, 'Anda Belum Memilih Shift !');
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShiftCubit>(context).getShift();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return CustomLoading();
              },
            );
          }
          if(state is LoginLoaded){
            // Navigator.pop(context);
            var json = state.json;
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Center(child: Image.asset('assets/img/bmt.jpeg')),
            )),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<ShiftCubit, ShiftState>(
                    builder: (context, state) {
                      if (state is ShiftLoading) {
                        return Center();
                      }
                      if (state is ShiftLoaded == false) {
                        return Center();
                      }
                      List<dynamic> data = (state as ShiftLoaded).json;
                      if (data.isEmpty) {
                        return Container();
                      }
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        height: 60,
                        child: DropdownButtonFormField<dynamic>(
                          decoration: InputDecoration(border: OutlineInputBorder()),
                          isExpanded: true,
                          value: dropdownvalue,
                          hint: Text('Pilih Shift'),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: data
                              .map((e) => DropdownMenuItem(
                                    child: Text(e['display']),
                                    value: e['value'],
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              print(dropdownvalue);
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(fixedSize: Size.fromWidth(200)),
                    child: Text("Scan QR"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

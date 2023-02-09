import 'package:bmt/source/data/Menu/Pulling/cubit/pulling_cubit.dart';
import 'package:bmt/source/data/Menu/Pulling/cubit/workcenter_cubit.dart';
import 'package:bmt/source/router/string.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:bmt/source/widget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Pulling extends StatefulWidget {
  const Pulling({super.key});

  @override
  State<Pulling> createState() => _PullingState();
}

class _PullingState extends State<Pulling> {

  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PullingCubit>(context).getCurrentPulling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isSearch
            ? TextFormField(
              autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  BlocProvider.of<PullingCubit>(context).searchData(value);
                },
              )
            : Text('Pulling', style: TextStyle(fontWeight: FontWeight.w600),),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: isSearch ? Icon(Icons.close) : Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<PullingCubit, PullingState>(
        builder: (context, state) {
          if (state is PullingLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PullingLoaded == false) {
            return Center(
              child: Text('No Data'),
            );
          }
          var json = (state as PullingLoaded).json;
          var statusCode = (state as PullingLoaded).statusCode;
          if (json.isEmpty) {
            return Center(
              child: Text('Data Kosong'),
            );
          }
          return Container(
            child: ListView.builder(
              itemCount: json.length,
              itemBuilder: (context, index) {
                var data = json[index];
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
                                Text(data['wo_code'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                Text(' | ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                Text(data['shift_name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(data['invp_date'], style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text('${data['pt_code']} ${data['pt_desc1']}', style: TextStyle(fontSize: 15)),
                      const SizedBox(height: 8.0),
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(90),
                          1: FixedColumnWidth(10),
                        },
                        children: [
                          TableRow(children: [
                            Text('Box Number'),
                            Text(':'),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Text(data['wopl_code']),
                            ),
                          ]),
                          TableRow(children: [
                            Text('Current WC'),
                            Text(':'),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(data['wc_desc']),
                            ),
                          ]),
                          TableRow(children: [
                            Text('Qty'),
                            Text(':'),
                            Text(data['invp_qty']),
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
      floatingActionButton: BlocListener<WorkcenterCubit, WorkcenterState>(
        listener: (context, state) {
          if (state is SkipWorkcenterLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const CustomLoading();
              },
            );
          }
          if (state is SkipWorkcenterLoaded) {
            Navigator.pop(context);
            var message = state.message;
            var statusCode = state.statusCode;
            var json = state.json;
            if (statusCode == 200) {
              MyAlertDialog.successDialog(context, message, () {
                BlocProvider.of<PullingCubit>(context).getCurrentPulling();
              });
            } else if (statusCode == 400) {
              MyAlertDialog.warningDialog(context, '$message \n ${json['msg']}');
            }
          }
          if (state is UnSkipWorkcenterLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const CustomLoading();
              },
            );
          }
          if (state is UnSkipWorkcenterLoaded) {
            Navigator.pop(context);
            var message = state.message;
            var statusCode = state.statusCode;
            var json = state.json;
            if (statusCode == 200) {
              MyAlertDialog.successDialog(context, message, () {
                BlocProvider.of<PullingCubit>(context).getCurrentPulling();
              });
            } else if (statusCode == 400) {
              MyAlertDialog.warningDialog(context, '$message \n ${json['msg']}');
            }
          }
        },
        child: SpeedDial(
          icon: Icons.menu,
          activeIcon: Icons.close,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          activeBackgroundColor: Colors.blue,
          activeForegroundColor: Colors.white,
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(FontAwesomeIcons.filter),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                label: 'Filter Data',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.pushNamed(context, FILTER_PULLING);
                },),
            SpeedDialChild(
              child: Icon(Icons.qr_code_sharp),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Insert',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, INSERT_PULLING);
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.qr_code_sharp),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                label: 'Skip Work Center',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  BlocProvider.of<WorkcenterCubit>(context).skipWorkCenter();
                }),
            SpeedDialChild(
                child: Icon(Icons.qr_code_sharp),
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                label: 'Unskip Work Center',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  BlocProvider.of<WorkcenterCubit>(context).unskipWorkCenter();
                }),

            //add more menu item childs here
          ],
        ),
      ),
    );
  }
}

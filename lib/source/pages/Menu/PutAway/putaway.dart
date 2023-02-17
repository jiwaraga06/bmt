import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/action_put_away_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/putaway_cubit.dart';
import 'package:bmt/source/pages/Menu/PutAway/tesprint.dart';
import 'package:bmt/source/router/string.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PutAway extends StatefulWidget {
  const PutAway({super.key});

  @override
  State<PutAway> createState() => _PutAwayState();
}

class _PutAwayState extends State<PutAway> {
  bool isSearch = false;
  TestPrint testPrint = TestPrint();
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  void getDivice() async {
    try {
      devices = await printer.getBondedDevices();
    } catch (e) {
      print('Error get divice: $e');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PutawayCubit>(context).currentPutaway();
    getDivice();
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
                    BlocProvider.of<PutawayCubit>(context).searchData(value);
                  },
                )
              : Text(
                  'Put Away',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
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
        body: BlocListener<ActionPutAwayCubit, ActionPutAwayState>(
          listener: (context, state) {
            if (state is ActionPrintPutAwayLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const CustomLoading();
                },
              );
            }
            if (state is ActionPrintPutAwayLoaded) {
              Navigator.pop(context);
            }
            if (state is ActionDeletePutAwayLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const CustomLoading();
                },
              );
            }
            if (state is ActionDeletePutAwayLoaded) {
              Navigator.pop(context);
              var statusCode = state.statusCode;
              var json = state.json;
              if (statusCode == 200) {
                MyAlertDialog.successDialog(context, json['msg'], () {
                  BlocProvider.of<PutawayCubit>(context).currentPutaway();
                });
              } else {
                MyAlertDialog.warningDialog(context, json['msg']);
              }
            }
          },
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // printer.isConnected.then((value) {
                  //   print('Is KONEK: $value');
                  // });
                  printer.isOn.then((value) {
                    print('Is ON: $value');
                  });
                  printer.isConnected.then((isConnected) {
                    print('isConnected: $isConnected');
                    if (!isConnected!) {
                      printer.connect(selectedDevice!).catchError((error) {
                        print('Error: $error');
                      });
                    }
                  });
                  // printer.disconnect();
                },
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<BluetoothDevice>(
                hint: Text('Printer'),
                value: selectedDevice,
                items: devices
                    .map((e) => DropdownMenuItem<BluetoothDevice>(
                          child: Text(e.name!),
                          value: e,
                        ))
                    .toList(),
                onChanged: (BluetoothDevice? value) {
                  setState(() {
                    selectedDevice = value;
                    print(selectedDevice!.name);
                  });
                },
              ),
              IconButton(
                onPressed: () async {
                  testPrint.sample();
                },
                icon: const Icon(Icons.print),
              ),
              const SizedBox(height: 10),
              BlocBuilder<PutawayCubit, PutawayState>(
                builder: (context, state) {
                  if (state is PutawayLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is PutawayLoaded == false) {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
                  var json = (state as PutawayLoaded).json;
                  if (json.isEmpty) {
                    return Center(
                      child: Text('Data Kosong'),
                    );
                  }
                  return Expanded(
                    child: Container(
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: json.length,
                      itemBuilder: (context, index) {
                        var data = json[index];
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  BlocProvider.of<ActionPutAwayCubit>(context).printPutaway(data['packld_oid'], context);
                                },
                                backgroundColor: Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.print,
                                label: 'PRINT',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  BlocProvider.of<ActionPutAwayCubit>(context).deletePutAway(data['packld_oid']);
                                },
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline,
                                label: 'DELETE',
                              ),
                            ],
                          ),
                          child: Container(
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
                                          Text(data['packld_code'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Text(data['packl_date'], style: TextStyle(fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Text('${data['ptnr_name']}', style: TextStyle(fontSize: 15)),
                                const SizedBox(height: 8.0),
                                // Image.network('http://182.253.45.29:88/api-dev04/assets/images/TDI001-230127-1-003.jpg'),
                                Table(
                                  columnWidths: const {
                                    0: FixedColumnWidth(90),
                                    1: FixedColumnWidth(10),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Text('Lot Number'),
                                      Text(':'),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: Text(data['packld_lot_no']),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Text('Qty'),
                                      Text(':'),
                                      Text(data['packld_qty_pack']),
                                    ]),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
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
                  Navigator.pushNamed(context, FILTER_PUT_AWAY);
                }),
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Insert',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, INSERT_PUT_AWAY);
              },
            ),
          ],
        ));
  }
}

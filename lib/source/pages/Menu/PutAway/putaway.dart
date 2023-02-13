import 'package:bmt/source/data/Menu/PutAway/cubit/action_put_away_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/putaway_cubit.dart';
import 'package:bmt/source/router/string.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
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
  ReceiptController? controller;
  String? address;

  Widget buildPrint(BuildContext context) {
    return Receipt(
      /// You can build your receipt widget that will be printed to the device
      /// Note that, this feature is in experimental, you should make sure your widgets will be fit on every device.
      builder: (context) => Column(children: [
        Text('Hello World'),
      ]),
      onInitialized: (controller) {
        this.controller = controller;
      },
    );
  }

  Future<void> print() async {
    final device = await FlutterBluetoothPrinter.selectDevice(context);
    if (device != null) {
      controller?.print(address: device.address);
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PutawayCubit>(context).currentPutaway();
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
              const SizedBox(height: 10),
              IconButton(
                onPressed: () async {
                  final selected = await FlutterBluetoothPrinter.selectDevice(context);
                  if (selected != null) {
                    setState(() {
                      address = selected.address;
                    });
                  }
                },
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () async {
                  final selectedAddress = address ?? (await FlutterBluetoothPrinter.selectDevice(context))?.address;

                  if (selectedAddress != null) {
                    PrintingProgressDialog.print(
                      context,
                      device: selectedAddress,
                      controller: controller!,
                    );
                  }
                },
                icon: const Icon(Icons.print),
              ),
              Receipt(
                backgroundColor: Colors.grey.shade200,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 36,
                        ),
                        child: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'PURCHASE RECEIPT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Divider(thickness: 2),
                      Table(
                        columnWidths: const {
                          1: IntrinsicColumnWidth(),
                        },
                        children: const [
                          TableRow(
                            children: [
                              Text('ORANGE JUICE'),
                              Text(r'$2'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('CAPPUCINO MEDIUM SIZE'),
                              Text(r'$2.9'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('BEEF PIZZA'),
                              Text(r'$15.9'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('ORANGE JUICE'),
                              Text(r'$2'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('CAPPUCINO MEDIUM SIZE'),
                              Text(r'$2.9'),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text('BEEF PIZZA'),
                              Text(r'$15.9'),
                            ],
                          ),
                        ],
                      ),
                      const Divider(thickness: 2),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Row(
                          children: const [
                            Text(
                              'TOTAL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              r'$200',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 2),
                      const Text('Thank you for your purchase!'),
                      const SizedBox(height: 24),
                    ],
                  );
                },
                onInitialized: (controller) {
                  setState(() {
                    this.controller = controller;
                  });
                },
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
                  return Container(
                      child: ListView.builder(
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
                  ));
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

class PrintingProgressDialog extends StatefulWidget {
  final String device;
  final ReceiptController controller;
  const PrintingProgressDialog({
    Key? key,
    required this.device,
    required this.controller,
  }) : super(key: key);

  @override
  State<PrintingProgressDialog> createState() => _PrintingProgressDialogState();
  static void print(
    BuildContext context, {
    required String device,
    required ReceiptController controller,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PrintingProgressDialog(
        controller: controller,
        device: device,
      ),
    );
  }
}

class _PrintingProgressDialogState extends State<PrintingProgressDialog> {
  double? progress;
  @override
  void initState() {
    super.initState();
    widget.controller.print(
      address: widget.device,
      linesAfter: 2,
      useImageRaster: true,
      keepConnected: true,
      onProgress: (total, sent) {
        if (mounted) {
          setState(() {
            progress = sent / total;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Printing Receipt',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 4),
            Text('Processing: ${((progress ?? 0) * 100).round()}%'),
            if (((progress ?? 0) * 100).round() == 100) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await FlutterBluetoothPrinter.disconnect(widget.device);
                  Navigator.pop(context);
                },
                child: const Text('Disconnect'),
              )
            ]
          ],
        ),
      ),
    );
  }
}

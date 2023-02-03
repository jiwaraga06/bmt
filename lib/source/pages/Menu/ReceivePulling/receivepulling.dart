import 'package:bmt/source/data/Menu/ReceivePulling/cubit/receive_pulling_cubit.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceivePulling extends StatefulWidget {
  const ReceivePulling({super.key});

  @override
  State<ReceivePulling> createState() => _ReceivePullingState();
}

class _ReceivePullingState extends State<ReceivePulling> {
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReceivePullingCubit>(context).recevieGetCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isSearch
              ? TextFormField(
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    BlocProvider.of<ReceivePullingCubit>(context).searchData(value);
                  },
                )
              : Text('Receive Pulling'),
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
        body: BlocBuilder<ReceivePullingCubit, ReceivePullingState>(
          builder: (context, state) {
            if (state is ReceivePullingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ReceivePullingLoaded == false) {
              return const Center();
            }
            var json = (state as ReceivePullingLoaded).json;
            var shift = (state as ReceivePullingLoaded).shift;
            if (json.isEmpty) {
              return const Center(
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
                                  Text(data['wopl_code'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  Text(' | ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  // Text(data['shift_name'].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  Text(shift.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Text(data['invpr_date'], style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Table(
                          columnWidths: const {
                            0: FixedColumnWidth(90),
                            1: FixedColumnWidth(10),
                          },
                          children: [
                            TableRow(children: [
                              Text('Qty Receive'),
                              Text(':'),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text(data['invpr_qty_receive']),
                              ),
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
                  Navigator.pushNamed(context, FILTER_RECEIVE_PULLING);
                }),
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Insert',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, INSERT_RECEIVE_PULLING);
              },
            ),
          ],
        ));
  }
}

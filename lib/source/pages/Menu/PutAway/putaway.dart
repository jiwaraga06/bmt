import 'package:bmt/source/data/Menu/PutAway/cubit/putaway_cubit.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PutAway extends StatefulWidget {
  const PutAway({super.key});

  @override
  State<PutAway> createState() => _PutAwayState();
}

class _PutAwayState extends State<PutAway> {
  DateTimeRange? _selectedDateRange;
  var tanggalAwal, tanggalAkhir;
  bool isSearch = false;
  void show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      print(result.end.toString());
      setState(() {
        _selectedDateRange = result;
        tanggalAwal = _selectedDateRange!.start.toString().split(' ')[0];
        tanggalAkhir = _selectedDateRange!.end.toString().split(' ')[0];
        BlocProvider.of<PutawayCubit>(context).putaway(tanggalAwal, tanggalAkhir);
      });
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
          title: isSearch
              ? TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    BlocProvider.of<PutawayCubit>(context).searchData(value);
                  },
                )
              : Text('Put Away'),
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
        body: BlocBuilder<PutawayCubit, PutawayState>(
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
                                Text(data['packld_code'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(data['packl_date'], style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text('${data['ptnr_name']}', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8.0),
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(90),
                          1: FixedColumnWidth(10),
                        },
                        children: [
                          TableRow(children: [
                            Text('Lot Number', style: TextStyle(fontSize: 15)),
                            Text(':', style: TextStyle(fontSize: 15)),
                            Text(data['packld_lot_no'], style: TextStyle(fontSize: 15)),
                          ]),
                          TableRow(children: [
                            Text('Qty', style: TextStyle(fontSize: 15)),
                            Text(':', style: TextStyle(fontSize: 15)),
                            Text(data['packld_qty_pack'], style: TextStyle(fontSize: 15)),
                          ]),
                        ],
                      )
                    ],
                  ),
                );
              },
            ));
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
                onTap: show),
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

import 'package:bmt/source/data/Menu/PackingList/cubit/packing_list_cubit.dart';
import 'package:bmt/source/router/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PacklingList extends StatefulWidget {
  const PacklingList({super.key});

  @override
  State<PacklingList> createState() => _PacklingListState();
}

class _PacklingListState extends State<PacklingList> {
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PackingListCubit>(context).getPackingListCurrent();
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
                )
              : Text('Packing List'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: isSearch ? Icon(Icons.close) : Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<PackingListCubit, PackingListState>(
          builder: (context, state) {
            if (state is PackingListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PackingListLoaded == false) {
              return const Center(child: Text('No Data'));
            }
            var json = (state as PackingListLoaded).json;
            if (json.isEmpty) {
              return const Center(child: Text('Data Kosong'));
            }
            return ListView.builder(
                itemCount: json.length,
                itemBuilder: (context, index) {
                  var data = json[index];
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1.2,
                        blurRadius: 1.2,
                        offset: Offset(1, 2),
                      )
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data['do_code'].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(data['do_date'].toString(), style: TextStyle(fontSize: 15)),
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
                              Text('SO Number'),
                              Text(':'),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(data['so_code']),
                              ),
                            ]),
                            TableRow(children: [
                              Text('Sold to'),
                              Text(':'),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(data['ptnr_name_sold']),
                              ),
                            ]),
                            TableRow(children: [
                              Text('Delivery Date'),
                              Text(':'),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(data['do_dlv_date']),
                              ),
                            ]),
                          ],
                        )
                      ],
                    ),
                  );
                });
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
                  Navigator.pushNamed(context, FILTER_PACKING_LIST);
                }),
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Insert',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, INSERT_PACKING_LIST);
              },
            ),
          ],
        ));
  }
}

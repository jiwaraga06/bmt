import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_save_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/header_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/packing_list_cubit.dart';
import 'package:bmt/source/pages/Menu/PackingList/detail.dart';
import 'package:bmt/source/pages/Menu/PackingList/header.dart';
import 'package:bmt/source/widget/customAlertDialog.dart';
import 'package:bmt/source/widget/customLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsertPackingList extends StatefulWidget {
  const InsertPackingList({super.key});

  @override
  State<InsertPackingList> createState() => _InsertPackingListState();
}

class _InsertPackingListState extends State<InsertPackingList> with TickerProviderStateMixin {
  TabController? _tabController;
  static const List<Widget> views = [
    HeaderPackingList(),
    DetailPackingList(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Kembali');
        BlocProvider.of<DetailPackingListCubit>(context).clearDataDetailPacking();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Insert Packing List', style: TextStyle(color: Colors.blue)),
          leading: IconButton(
              onPressed: () {
                print('Kembali');
                Navigator.pop(context);
                BlocProvider.of<DetailPackingListCubit>(context).clearDataDetailPacking();
              },
              icon: Icon(Icons.arrow_back, color: Colors.blue)),
          actions: [
            TextButton(
              onPressed: () {
                BlocProvider.of<DetailPackingSaveCubit>(context).savePackingList();
              },
              child: Text('SAVE', style: TextStyle(color: Colors.blue)),
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            tabs: const [
              Tab(text: 'HEADER'),
              Tab(text: 'DETAIL'),
            ],
          ),
        ),
        body: BlocListener<DetailPackingSaveCubit, DetailPackingSaveState>(
          listener: (context, state) {
            if (state is DetailPackingSaveLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const CustomLoading();
                },
              );
            }
            if (state is DetailPackingSaveLoaded) {
              Navigator.pop(context);
              var statusCode = state.statusCode;
              var json = state.json;
              if (statusCode == 200) {
                MyAlertDialog.successDialog(context, json['msg'], () {
                  Navigator.pop(context);
                  BlocProvider.of<PackingListCubit>(context).getPackingListCurrent();
                });
              } else {
                MyAlertDialog.warningDialog(context, json['msg']);
              }
            }
          },
          child: TabBarView(controller: _tabController, children: views),
        ),
      ),
    );
  }
}

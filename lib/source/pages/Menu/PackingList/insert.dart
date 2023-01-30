import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/header_packing_list_cubit.dart';
import 'package:bmt/source/pages/Menu/PackingList/detail.dart';
import 'package:bmt/source/pages/Menu/PackingList/header.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Insert Packing List', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.blue)),
        actions: [
          TextButton(
            onPressed: () {
              print(_tabController!.index);
              if (_tabController!.index == 0) {
                BlocProvider.of<HeaderPackingListCubit>(context).header();
              } else {
                BlocProvider.of<DetailPackingListCubit>(context).detail();
              }
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
      body: TabBarView(controller: _tabController, children: views),
    );
  }
}

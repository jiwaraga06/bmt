import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_cubit.dart';
import 'package:bmt/source/widget/customBtnScanQr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPackingList extends StatefulWidget {
  const DetailPackingList({super.key});

  @override
  State<DetailPackingList> createState() => _DetailPackingListState();
}

class _DetailPackingListState extends State<DetailPackingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0, bottom: 12.0),
            child: CustomButtonScanQR(
              onTap: () {
                BlocProvider.of<DetailPackingListCubit>(context).scanDetail();
              },
              text: 'Scan Box Customer',
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PacklingList extends StatefulWidget {
  const PacklingList({super.key});

  @override
  State<PacklingList> createState() => _PacklingListState();
}

class _PacklingListState extends State<PacklingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Packing List'),
      ),
    );
  }
}
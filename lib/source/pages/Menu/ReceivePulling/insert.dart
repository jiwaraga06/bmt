import 'package:flutter/material.dart';

class InsertReceivePulling extends StatefulWidget {
  const InsertReceivePulling({super.key});

  @override
  State<InsertReceivePulling> createState() => _InsertReceivePullingState();
}

class _InsertReceivePullingState extends State<InsertReceivePulling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Receive Pulling'),
      ),
    );
  }
}
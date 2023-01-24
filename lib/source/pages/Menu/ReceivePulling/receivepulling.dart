import 'package:flutter/material.dart';

class ReceivePulling extends StatefulWidget {
  const ReceivePulling({super.key});

  @override
  State<ReceivePulling> createState() => _ReceivePullingState();
}

class _ReceivePullingState extends State<ReceivePulling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receive Pulling'),
      ),
    );
  }
}
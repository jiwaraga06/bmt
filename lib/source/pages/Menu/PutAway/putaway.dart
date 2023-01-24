import 'package:flutter/material.dart';

class PutAway extends StatefulWidget {
  const PutAway({super.key});

  @override
  State<PutAway> createState() => _PutAwayState();
}

class _PutAwayState extends State<PutAway> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Put Away'),),
    );
  }
}
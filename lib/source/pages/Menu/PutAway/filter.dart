import 'package:bmt/source/data/Menu/Pulling/cubit/pulling_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/putaway_cubit.dart';
import 'package:bmt/source/widget/customTextFieldRead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPutAway extends StatefulWidget {
  const FilterPutAway({super.key});

  @override
  State<FilterPutAway> createState() => _FilterPutAwayState();
}

class _FilterPutAwayState extends State<FilterPutAway> {
  TextEditingController controllerTanggalAwal = TextEditingController();
  TextEditingController controllerTanggalAkhir = TextEditingController();
  void pilihTanggalAwal() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now(),
    );
    print('Tgl Awal: ${date.toString().split(' ')[0]}');
    if (date.toString().split(' ')[0] != null) {
      setState(() {
        controllerTanggalAwal = TextEditingController(text: date.toString().split(' ')[0]);
      });
    } else {
      setState(() {
        controllerTanggalAwal = TextEditingController(text: '');
      });
    }
  }

  void pilihTanggalAkhir() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now(),
    );
    print('Tgl Akhir: ${date.toString().split(' ')[0]}');
    if (date.toString().split(' ')[0] != null) {
      setState(() {
        controllerTanggalAkhir = TextEditingController(text: date.toString().split(' ')[0]);
      });
    } else {
      setState(() {
        controllerTanggalAkhir = TextEditingController(text: '');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var date = DateTime.now();
    controllerTanggalAwal = TextEditingController(text: date.toString().split(' ')[0]);
    controllerTanggalAkhir = TextEditingController(text: date.toString().split(' ')[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Data PutAway'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: controllerTanggalAwal,
              readOnly: true,
              onTap: pilihTanggalAwal,
              decoration: InputDecoration(labelText: 'Tanggal Awal'),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: controllerTanggalAkhir,
              readOnly: true,
              onTap: pilihTanggalAkhir,
              decoration: InputDecoration(labelText: 'Tanggal Akhir'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<PutawayCubit>(context).putaway(controllerTanggalAwal.text, controllerTanggalAkhir.text);
                  Navigator.pop(context);
                },
                child: Text('Retrieve Data'))
          ],
        ),
      ),
    );
  }
}

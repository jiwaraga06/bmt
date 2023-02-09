import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bmt/source/data/Auth/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountCubit>(context).getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Logout', style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AccountLoaded == false) {
            return const Center(
              child: Text('Data Failed'),
            );
          }
          var data = (state as AccountLoaded).json;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data['username'], style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text(data['shiftname'], style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.bottomSlide,
                        title: 'Information !',
                        desc: 'Apakah Anda Yakin Ingin Keluar ? ',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          BlocProvider.of<AccountCubit>(context).logout(context);
                        },
                      )..show();
                    },
                    child: Text('Logout'))
              ],
            ),
          );
        },
      ),
    );
  }
}

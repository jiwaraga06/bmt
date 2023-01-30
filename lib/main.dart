import 'package:bmt/source/data/Auth/cubit/account_cubit.dart';
import 'package:bmt/source/data/Auth/cubit/login_cubit.dart';
import 'package:bmt/source/data/Auth/cubit/shift_cubit.dart';
import 'package:bmt/source/data/Auth/cubit/splash_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/detail_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/header_packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/PackingList/cubit/packing_list_cubit.dart';
import 'package:bmt/source/data/Menu/Pulling/cubit/insert_scan_cubit.dart';
import 'package:bmt/source/data/Menu/Pulling/cubit/pulling_cubit.dart';
import 'package:bmt/source/data/Menu/Pulling/cubit/save_pulling_cubit.dart';
import 'package:bmt/source/data/Menu/Pulling/cubit/workcenter_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/detail_save_putaway_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/insert_put_away_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/putaway_cubit.dart';
import 'package:bmt/source/data/Menu/PutAway/cubit/save_put_away_cubit.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:bmt/source/network/network.dart';
import 'package:bmt/source/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;

  const MyApp({super.key, this.router, this.myRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => ShiftCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => LoginCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => PullingCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => InsertScanCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => SavePullingCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => WorkcenterCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => PutawayCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => InsertPutAwayCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => SavePutAwayCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => DetailSavePutawayCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => AccountCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => PackingListCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => HeaderPackingListCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => DetailPackingListCubit(myRepository: myRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}

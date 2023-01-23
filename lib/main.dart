import 'package:bmt/source/data/Auth/cubit/shift_cubit.dart';
import 'package:bmt/source/data/Auth/cubit/splash_cubit.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}

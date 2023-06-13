import 'package:chess_clock/features/timer/presentation/views/timer.dart';
import 'package:flutter/material.dart';
import 'package:chess_clock/features/timer/presentation/blocs/timer_bloc.dart';
import 'package:chess_clock/features/timer/data/models/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TimerBloc(ticker: const Ticker()),
        child: const MyTimer(),
      ),
    );
  }
}

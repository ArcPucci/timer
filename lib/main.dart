import 'package:cubit/blocs/timer_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TimerBloc _timerBloc = TimerBloc();

  @override
  void initState() {
    _timerBloc.add(StartTimer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer list"),
      ),
      body: BlocProvider.value(
        value: _timerBloc,
        child: BlocBuilder<TimerBloc, TimerState>(
          buildWhen: (prev, curr) => true,
          builder: (context, state) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) => Text(state.list[index].toString(), textAlign: TextAlign.center,),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    thickness: 2,
                  ),
              itemCount: state.list.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTimer,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTimer() {
    _timerBloc.add(AddTimer());
  }
}

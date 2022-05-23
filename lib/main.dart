import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'providers/bg_color.dart';
import 'providers/counter.dart';
import 'providers/customer_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ProxyProvider 와 마찬가지로 순서가 바뀌면 오류가 난다.
        // 영향을 주는 provider 는 provider 보다 먼저 표기해야 함
        StateNotifierProvider<BgColor, BgColorState>(
          create: (context) => BgColor(),
        ),
        StateNotifierProvider<Counter, CounterState>(
          create: (context) => Counter(),
        ),
        StateNotifierProvider<CustomerLevel, Level>(
          create: (context) => CustomerLevel(),
        ),
      ],
      child: MaterialApp(
        title: 'StateNotifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();

    return Scaffold(
      backgroundColor: levelState == Level.bronze
          ? Colors.white
          : levelState == Level.silver
          ? Colors.grey
          : Colors.yellow,
      appBar: AppBar(
        backgroundColor: colorState.color,
        title: const Text('StateNotifier'),
      ),
      body: Center(
        child: Text(
          '${counterState.counter}',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Increment',
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<Counter>().increment();
            },
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            tooltip: 'Change Color',
            child: const Icon(Icons.color_lens_outlined),
            onPressed: () {
              context.read<BgColor>().changeColor();
            },
          ),
        ],
      ),
    );
  }
}

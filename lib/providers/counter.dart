import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:state_notifier_test/providers/customer_level.dart';

import 'bg_color.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({
    required this.counter,
  });

  @override
  List<Object> get props => [counter];

  @override
  bool get stringify => true;

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

// Counter 는 BgColor 의 state 를 읽어야 하므로
// ProxyProvider 대신 LocatorMixin 를 사용함.
class Counter extends StateNotifier<CounterState> with LocatorMixin {
  Counter() : super(const CounterState(counter: 0));

  void increment() {
    Color currentColor = read<BgColor>().state.color;
    // debugPrint('-- counter>>increment: ' + currentColor.toString());

    // appBar 의 배경색에 따라서 값 증분이 달라짐.
    if (currentColor == Colors.black) {
      state = state.copyWith(counter: state.counter + 10);
    } else if (currentColor == Colors.red) {
      state = state.copyWith(counter: state.counter - 10);
    } else {
      state = state.copyWith(counter: state.counter + 1);
    }
  }

  // 다른 object의 변경사항을 listen 할수 있음,
  // update 는 의존하는 다른 state 가 변경될때 마다 호출된다.
  // ProxyProvider 가 다른 provider 에 하는것과 동일한 기능
  @override
  void update(Locator watch) {
    // debugPrint('----- counter>>update(BgColor): nothing');
    debugPrint('----- counter>>update(BgColor): ${watch<BgColorState>().color.toString()}');
    debugPrint('----- counter>>update(BgColor): ${watch<BgColor>().state.color.toString()}');
    super.update(watch);
  }
}

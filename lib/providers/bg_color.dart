import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

class BgColorState extends Equatable {
  final Color color;
  const BgColorState({
    required this.color,
  });

  @override
  List<Object> get props => [color];

  @override
  bool get stringify => true;

  BgColorState copyWith({
    Color? color,
  }) {
    return BgColorState(
      color: color ?? this.color,
    );
  }
}

class BgColor extends StateNotifier<BgColorState> {
  BgColor() : super(const BgColorState(color: Colors.blue));

  void changeColor() {
    // state 변수는 super 전달하는 값이 초기값이다.
    // notifyListeners 호출 안함.
    if (state.color == Colors.blue) {
      state = state.copyWith(color: Colors.black);
    } else if (state.color == Colors.black) {
      state = state.copyWith(color: Colors.red);
    } else {
      state = state.copyWith(color: Colors.blue);
    }
  }
}

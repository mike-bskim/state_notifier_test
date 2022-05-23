import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:state_notifier_test/providers/bg_color.dart';

import 'counter.dart';

enum Level {
  bronze,
  silver,
  gold,
}

class CustomerLevel extends StateNotifier<Level> with LocatorMixin {
  CustomerLevel() : super(Level.bronze);

  // update 는 의존하는 다른 state 가 변경될때 마다 호출된다.
  @override
  void update(Locator watch) {
    final currentCounter = watch<CounterState>().counter;
    // debugPrint('----- level>>update(counter): ${currentCounter.toString()}');
    // debugPrint('----- level>>update(bgColor): ${watch<BgColorState>().color.toString()}');

    if (currentCounter >= 100) {
      state = Level.gold;
    } else if (currentCounter > 50 && currentCounter < 100) {
      state = Level.silver;
    } else {
      state = Level.bronze;
    }
    super.update(watch);
  }
}

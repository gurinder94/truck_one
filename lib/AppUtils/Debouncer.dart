import 'dart:async';
import 'dart:ui';

class Debouncer {
  VoidCallback? action;
  Timer? _timer;


  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: 500), action);
  }
}
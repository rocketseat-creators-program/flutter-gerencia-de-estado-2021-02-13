abstract class Reactive<T> {
  T _actual;

  T get value => _actual;

  final _listens = <Function>[];

  Reactive(T initial) {
    _actual = initial;
  }
  void update(T newState) {
    _actual = newState;
    _notifyListens();
  }

  void listen(void Function(T actual) onChange) {
    _listens.add(onChange);
  }

  //-R
  void _notifyListens() {
    for (var i = 0; i < _listens.length; i++) {
      _listens[i](_actual);
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive/src/reactive.dart';

class ListReactive extends Reactive<List<int>> {
  ListReactive() : super([]);
}

class EasyReactive extends Reactive<bool> {
  EasyReactive() : super(false);
}

void main() {
  ListReactive reactive;

  setUp(() {
    reactive = ListReactive();
  });

  test("Testando o Reactive", () {
    var _list = <int>[];
    expect(reactive, isInstanceOf<ListReactive>());
    expect(reactive.value, isInstanceOf<List<int>>());
    reactive.listen((actual) {
      _list = actual;
      print(_list);
    });
    for (var i = 0; i < 10; i++) {
      final _actuaList = reactive.value;
      _actuaList.add(i);
      reactive.update(_actuaList);
    }
    expect(_list, reactive.value);
  });

  test("Testando 100 listens", () {
    final reactive = EasyReactive();
    for (var i = 0; i < 100000; i++) {
      reactive.listen((actual) {});
    }
    final start = DateTime.now();
    for (var i = 0; i < 1000; i++) {
      reactive.update(true);
    }
    final end = DateTime.now();
    print(
        "${(end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000} segundos");
  });
}

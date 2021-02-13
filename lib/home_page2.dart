import 'package:flutter/material.dart';

abstract class Reactive<T> {
  T _actual;
  T get value => _actual;

  final _listeners = <Function>[];

  Reactive(T initial) {
    _actual = initial;
  }

  void update(T newState) {
    _actual = newState;
    _notifyListeners(_actual);
  }

  void listen(void Function(T actual) onChange) {
    _listeners.add(onChange);
  }

  void _notifyListeners(T actual) {
    for (var i = 0; i < _listeners.length; i++) {
      _listeners[i](actual);
    }
  }
}

class HomeController extends Reactive<int> {
  HomeController() : super(0);
}

class HomePage2 extends StatefulWidget {
  HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  var controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page 2"),
      ),
      body: Center(
        child: ReactiveBuilder<int>(
          controller: controller,
          builder: (_, value) => Text("Contador: $value"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.update(controller.value + 1);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ReactiveBuilder<T> extends StatefulWidget {
  final Reactive<T> controller;
  final Widget Function(BuildContext context, T value) builder;
  const ReactiveBuilder({
    Key key,
    @required this.controller,
    this.builder,
  }) : super(key: key);

  @override
  _ReactiveBuilderState<T> createState() => _ReactiveBuilderState<T>();
}

class _ReactiveBuilderState<T> extends State<ReactiveBuilder<T>> {
  @override
  void initState() {
    widget.controller.listen((actual) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.controller.value);
  }
}

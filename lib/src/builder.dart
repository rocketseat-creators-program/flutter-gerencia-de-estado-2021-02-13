import 'package:flutter/material.dart';

import 'package:reactive/src/reactive.dart';

class ReactiveBuilder<T> extends StatefulWidget {
  final Reactive<T> reactive;
  final Widget Function(BuildContext context, T value) builder;
  ReactiveBuilder({
    Key key,
    @required this.reactive,
    @required this.builder,
  }) : super(key: key);

  @override
  _ReactiveBuilderState<T> createState() => _ReactiveBuilderState<T>();
}

class _ReactiveBuilderState<T> extends State<ReactiveBuilder<T>> {
  T _actual;

  @override
  void initState() {
    _actual = widget.reactive.value;
    widget.reactive.listen((actual) {
      _actual = actual;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _actual);
  }
}

import 'package:flutter/material.dart';
import 'package:reactive/src/builder.dart';
import 'package:reactive/src/reactive.dart';

class HomeReactive extends Reactive<bool> {
  HomeReactive() : super(false);
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final reactive1 = HomeReactive();
  final reactive2 = HomeReactive();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            child: Text("Tap reactive 1"),
            onPressed: () {
              reactive1.update(!reactive1.value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ReactiveBuilder<bool>(
            reactive: reactive1,
            builder: (_, value) => value
                ? Container(
                    width: 200,
                    height: 200,
                    color: Colors.green,
                    child: Center(child: Text("Reactive 1")),
                  )
                : Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: Center(child: Text("Reactive 1")),
                  ),
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            child: Text("Tap reactive 2"),
            onPressed: () {
              reactive2.update(!reactive2.value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ReactiveBuilder<bool>(
            reactive: reactive2,
            builder: (_, value) => value
                ? Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(child: Text("Reactive 2")),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.yellow,
                    child: Center(child: Text("Reactive 2")),
                  ),
          ),
        ],
      ),
    );
  }
}

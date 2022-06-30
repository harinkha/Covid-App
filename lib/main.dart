import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 255, 242),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 249, 255, 242),
        title: Text(
          "                14 days\n Self-isolation countdown",
          style: TextStyle(color: Color.fromARGB(255, 154, 155, 159)),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => print("Debug"),
          icon: const Icon(Icons.keyboard_arrow_left),
          color: Color.fromARGB(255, 12, 134, 246),
          iconSize: 40,
        ),
        actions: [
          IconButton(
            onPressed: () => print("Debug"),
            icon: const Icon(Icons.menu),
            color: Color.fromARGB(255, 12, 134, 246),
            iconSize: 30,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

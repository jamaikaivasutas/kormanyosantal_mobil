import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dadaizmus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Dadaizmus versek'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Tóth Albert'),
              Padding(
                padding: EdgeInsetsGeometry.directional(bottom: 20),
                child: const Text(
                  'Tartalom(jegyzék)',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),

              Text('''
Kinyitottam életregényemet, lapoztam
benne, és a "tartalmas életút" fejezet
címnél hosszan elidőztem, kissé haboztam,
ez most sok vagy kevés, vakartam a fejemet,

Nézem, pláne objektíve, ez édes kevés,
ám racionális barátom most így szólna,
"de mihez képest", az élet egy befektetés,
hol béke, hol az élni akarás forradalma.

Az epilógussal nem bíbelődök, minek,
dolgozzon azon valaki más, de már ne én,
lehet, a konklúziót majd meg sem értitek.
Ui: de hisz ez egy dadaista költemény!
'''),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

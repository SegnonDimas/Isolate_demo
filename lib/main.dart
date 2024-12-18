import 'dart:isolate';

import 'package:flutter/material.dart';

import 'classes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade900),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Personne personne = Personne(25, 'Dimas', 25000000);
    personne.deposer(15000);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularProgressIndicator(),
                    CircularProgressIndicator(),
                    CircularProgressIndicator(),
                  ],
                ),*/
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearProgressIndicator(),
                ),
                /*CupertinoActivityIndicator(
                  radius: 50,
                ),*/
              ],
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Text('Saison ${index + 1}');
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: 2000),
            ))
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final receivePort = ReceivePort();
              await Isolate.spawn(isolateTask, receivePort.sendPort);
              receivePort.listen((compteur) {});
            },
            tooltip: 'Tâche complexe gérée avec isolate',
            child: const Text('Isolate'),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              task(100000);
              //var compteur = task(10000);
              // debugPrint(compteur as String?);
            },
            tooltip: 'Tâche complexe gérée sans isolate',
            child: const Text('Task 1'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  int task(int iterations) {
    int compteur = 0;
    for (int i = 0; i < iterations; i++) {
      compteur++;
      print('Compteur :::: => $compteur');
    }
    return compteur;
  }

  isolateTask(SendPort sendPort) {
    double compteur = 0;
    for (int i = 0; i < 100000; i++) {
      compteur++;
      print('Isolate :::: => $compteur');
    }
    sendPort.send(compteur);
  }
}

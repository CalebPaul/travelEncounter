import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travel_encounters/EncounterModel.dart';
import 'dart:convert';
import 'package:travel_encounters/Events.dart';
import "dart:math";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random TTRPG Travel Encounters',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Random Travel Encounters'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Events> _events = [];
  var eventText = "";

  @override
  void initState() {
    _getEvents().then((data) {
      setState(() {
        _events = data;
      });
    });
    super.initState();
  }

  _getEvents() async {
    String rawString = await rootBundle.loadString('data/encounter_data.json');

    Map rawList = json.decode(rawString);

    var cleanList = EncounterModel.fromJsonMap(rawList).events;

    eventText = cleanList[Random().nextInt(cleanList.length)].event;

    return cleanList;
  }

  void _newEncounter() {
    setState(() {
      eventText = _events[Random().nextInt(_events.length)].event;
      print("encounter: $eventText");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title)),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),


        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shadowColor: Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SelectableText(
                      eventText,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: _newEncounter,
        tooltip: 'New Encounter!',
        child: Icon(Icons.auto_awesome),
      ),
      bottomSheet: SelectableText(
        'credit to /u/cairfrey for curating these plothooks',
        style: Theme.of(context).textTheme.bodyText2,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

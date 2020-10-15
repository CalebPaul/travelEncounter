import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travel_encounters/EncounterModel.dart';
import 'dart:convert';
import 'dart:developer' as dev;
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
        primarySwatch: Colors.blue,
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
    String rawString = await rootBundle.loadString('encounter_data.json');

    Map rawList = json.decode(rawString);

    var cleanList = EncounterModel.fromJsonMap(rawList).events;

    for (var event in cleanList) {
      dev.log(event.event);
    }

    eventText = cleanList[Random().nextInt(cleanList.length)].event;

    return cleanList;
  }


  void _newEncounter() {
    setState(() {
      eventText = _events[Random().nextInt(_events.length)].event;
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shadowColor: Colors.greenAccent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  eventText,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newEncounter,
        tooltip: 'New Encounter!',
        child: Icon(Icons.auto_awesome),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

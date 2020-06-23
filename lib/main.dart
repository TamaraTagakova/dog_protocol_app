// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dogprotocolapp/repository.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Karren Overall's Relaxation Protocol",
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: ProtocolDays(),
    );
  }
}

class ProtocolDays extends StatefulWidget {
  @override
  _ProtocolDaysState createState() => _ProtocolDaysState();
}

class _ProtocolDaysState extends State<ProtocolDays>
    with TickerProviderStateMixin {
  final DaysList = new Repository().getDaysList();
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }


  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Relaxation Protocol"),
      ),
      body: _buildDaysList(),
    );
  }

  Widget _buildDaysList() {
    return ListView.separated(
      itemCount: DaysList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(DaysList[index], index);
      },
    );
  }

  Widget _buildRow(Day day, int index) {
//    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        day.title,
        style: _biggerFont,
      ),
      onTap: () {
        setState(() {
          _pushDay(day, index);
        });
      },
    );
  }

  void _pushDay(Day day, index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = day.ExerciseList.map(
            (Exercise exercise) {
              return ListTile(
                title: Text(
                  exercise.title,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(day.title),
            ),
            body: ListView(children: divided),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Container(
                height: 50.0,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _pushStart(day);
                }); // Add your onPressed code here!
              },
              child: Icon(Icons.play_arrow),
              backgroundColor: Colors.green,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }

  void _pushStart(day) {
    final exerciseList = day.ExerciseList;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          int index = 0;
          return Scaffold(
            appBar: AppBar(
              title: Text(day.title),
            ),
            body: Center(
                child: Text(exerciseList[index].title,
                    style: TextStyle(fontSize: 25.0))),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Container(
                height: 50.0,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _pushNext(day.title, exerciseList, ++index);
                }); // Add your onPressed code here!
              },
              child: Icon(Icons.play_arrow),
              backgroundColor: Colors.green,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }

  void _pushNext(title, exerciseList, index) {
    if (index >= exerciseList.length) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: Center(
                  child: Text(exerciseList[index].title,
                      style: TextStyle(fontSize: 25.0))),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Container(
                  height: 50.0,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _pushNext(title, exerciseList, ++index);
                  });
                },
                child: Icon(Icons.play_arrow),
                backgroundColor: Colors.green,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            );
          },
        ),
      );
    }
  }
}

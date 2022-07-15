// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Camera Permissions';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: FutureBuilder(
          future: verifyCameraPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return MyCameraButton(snapshot.data);
            }
          },
        ),
      ),
    );
  }
}

verifyCameraPermission() async {
  var cameraStatus = await Permission.camera.status;
  var isGranted = cameraStatus.isGranted;
  return isGranted;
}

class MyCameraButton extends StatelessWidget {
  var _isGranted;
  MyCameraButton(this._isGranted);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
              icon: const Icon(Icons.camera_alt),
              color: Colors.white,
              onPressed: _isGranted
                  ? null
                  : () async {
                      Permission.camera.request();
                    }),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Show/Hide Widget',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isVisible = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Show/Hide Widget'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Visibility(
//               visible: isVisible,
//               maintainSize: true,
//               maintainAnimation: true,
//               maintainState: true,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 color: Colors.green,
//               ),
//             ),
//             RaisedButton(
//               child: Text('Show/Hide'),
//               onPressed: () {
//                 setState(() {
//                   isVisible = !isVisible;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Startup Name Generator'), actions: [
//           IconButton(
//             icon: const Icon(Icons.camera_alt_rounded),
//             tooltip: 'Camera Permission',
//             onPressed: () {
//               cameraPermission();
//             },
//           ),
//         ]),
//         body: const Center(
//           child: RandomWords(),
//         ),
//       ),
//     );
//   }
// }

// class Alert extends StatefulWidget {
//   AlertState createState() => AlertState();
// }

// class AlertState extends State {
//   @override
//   void initState() {
//     showAlert(context);
//     super.initState();
//   }

//   Future showAlert(BuildContext context) async {
//     await Future.delayed(Duration(seconds: 6));

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text('Welcome To Our App :) .'),
//           actions: <Widget>[
//             FlatButton(
//               child: new Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Text(
//         'Call A Function Automatically When App Starts Everytime',
//         style: TextStyle(
//           fontSize: 22,
//         ),
//         textAlign: TextAlign.center,
//       )),
//     );
//   }
// }

// class RandomWords extends StatefulWidget {
//   const RandomWords({Key? key}) : super(key: key);

//   @override
//   State<RandomWords> createState() => _RandomWordsState();
// }

// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18);

//   @override
//   void initState() {
//     super.initState();
//     cameraPermission();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemBuilder: /*1*/ (context, i) {
//         if (i.isOdd) return const Divider(); /*2*/

//         final index = i ~/ 2; /*3*/
//         if (index >= _suggestions.length) {
//           _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//         }
//         return ListTile(
//           title: Text(
//             _suggestions[index].asPascalCase,
//             style: _biggerFont,
//           ),
//         );
//       },
//     );
//   }
// }



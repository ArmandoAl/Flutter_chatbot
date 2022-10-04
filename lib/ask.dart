// @dart=2.9
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import the package that contains the Firebase SDK

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Ask(title: 'Sophia'),
    );
  }
}

class Ask extends StatefulWidget {
  const Ask({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {
  final TextEditingController _textAskController = TextEditingController();
  final TextEditingController _textAnsController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _userAnswer;
  String _askUser;

  @override
  void initState() {
    super.initState();
    usersA();
  }

  void usersA() async {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        // ignore: avoid_print
        print(doc.data());
      }
    });
  }

  void addUser() async {
    FirebaseFirestore.instance.collection('users').add({
      "UserAnswer": _userAnswer,
      "askUser": _askUser,
    }).then((value) {
      debugPrint('User added');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sophia', style: TextStyle(color: Color(0xFF00FFF5))),
        //add this background color to the appbar 0xFF00FFF5
        backgroundColor: const Color(0xFF222831),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFF393E46),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //put a padding of 20 on the top  bottom
          children: <Widget>[
            TextField(
              //put a padding to the textfield
              controller: _textAskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                fillColor: Color(0xFF00FFF5),
                filled: true,
                hintText: 'Write something here',
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (String text) {
                setState(() {
                  _askUser = _textAskController.text;
                  _askUser = _askUser.toLowerCase();
                });
              },
            ),
            TextField(
              controller: _textAnsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                fillColor: Color(0xFF00FFF5),
                filled: true,
                hintText: 'Write something here',
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (String text) {
                setState(() {
                  _userAnswer = _textAnsController.text;
                  _userAnswer = _userAnswer.toLowerCase();
                });
              },
            ),
            IconButton(
              onPressed: () {
                addUser();
              },
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}

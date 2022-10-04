// @dart=2.9
// ignore: import_of_legacy_library_into_null_safe
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sophia_v3/global.dart';
import 'package:sophia_v3/ask.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sophia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeChat(title: 'Sophia'),
    );
  }
}

class HomeChat extends StatefulWidget {
  const HomeChat({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  void initState() {
    start();
    super.initState();
  }

  final TextEditingController _textController = TextEditingController();

  void _onPressed(String text) async {
    final DialogFlowtter dialogFlowtter = await start();

    QueryInput query = QueryInput(text: TextInput(text: text));
    DetectIntentResponse res = await dialogFlowtter.detectIntent(
      queryInput: query,
    );

    setState(() {
      _chatBotResponse = res.text;
      _width = 10;
      _height = 5;
    });

    if (res.text == "Hi ask") {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ask(
                      title: widget.title,
                    )));
      });
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _width = _chatBotResponse.length * 10;
        _height = _chatBotResponse.length * 1;
      });

      if (_height < 50) {
        _height = 65;
      }
    });
  }

  String _chatBotResponse =
      "Hello, I am Sophia, your virtual asistant. How can I help you?";
  String _askUser = "Ask me anything";
  var _width = 200;
  var _height = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sophia', style: TextStyle(color: Color(0xFF00FFF5))),
        //add this background color to the appbar 0xFF00FFF5
        backgroundColor: const Color(0xFF222831),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF222831),
        ),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              margin: const EdgeInsets.only(top: 10),
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF00FFF5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              duration: const Duration(milliseconds: 500),
              child: Text(
                _askUser.toUpperCase(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF222831),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF393E46),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: 120,
                                    height: 200,
                                    margin: const EdgeInsets.all(10.0),
                                    alignment: Alignment.topLeft,
                                    child: const RiveAnimation.asset(
                                      'assets/sophia.riv',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 230,
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                padding: const EdgeInsets.all(8.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00FFF5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                width: _width.toDouble(),
                                height: _height.toDouble(),
                                child: Text(
                                  _chatBotResponse,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF222831),
                                  ),
                                ),
                              ),
                            ),
                            //This is for the links
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Make a container with a imput field and a button
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
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
                          _askUser = _textController.text;
                          _askUser = _askUser.toLowerCase();
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _onPressed(_textController.text);
                      _textController.clear();
                    },
                    icon: const Icon(Icons.send),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

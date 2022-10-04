// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rive/rive.dart';
import 'package:sophia_v3/chat.dart';
import 'package:sophia_v3/global.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sophia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sophia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 150),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Give help",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_circle_right),
                      onPressed: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ads(
                              title: widget.title,
                            ),
                          ),
                        ); */
                        debugPrint("Yes");
                      },
                    ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 200,
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child: const RiveAnimation.asset(
                    'assets/sophia.riv',
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      "Hi, I'm Sophia",
                      speed: const Duration(milliseconds: 100),
                    ),
                    TyperAnimatedText(
                      "Do you want to start a conversation?",
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_circle_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeChat(
                          title: widget.title,
                        ),
                      ),
                    );
                    func();
                    debugPrint("Si");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

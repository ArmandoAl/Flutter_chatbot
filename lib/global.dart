import 'package:dialog_flowtter/dialog_flowtter.dart';

// ignore: avoid_print
void func() => print('Hello');

Future<DialogFlowtter> start() async {
  DialogAuthCredentials credentials =
      await DialogAuthCredentials.fromFile('assets/dialog_flow_auth.json');
  // ignore: unused_local_variable
  DialogFlowtter instance = DialogFlowtter(
    credentials: credentials,
  );
  DialogFlowtter dialogFlowtter = DialogFlowtter(
    credentials: credentials,
    sessionId: "12345",
  );
  return dialogFlowtter;
}

/* // @dart=2.9
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

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
      home: const Ads(title: 'Sophia'),
    );
  }
}

class Ads extends StatefulWidget {
  const Ads({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  InterstitialAd _interstitialAd;
  @override
  void initState() {
    super.initState();

    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3690221825949572/8123963996',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) =>
          debugPrint('$ad impression occurred.'),
    );
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
        decoration: const BoxDecoration(
          color: Color(0xFF222831),
        ),
        child: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () async {
            _interstitialAd.show();
          },
        ),
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// const String testDevice = '';

// class _MyHomePageState extends State<MyHomePage> {
//   static final MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
//     testDevices: <String>[],
//     keywords: <String>["Wallpapers", "walls"],
//     childDirected: true,
//   );
//   BannerAd _bannerAd;
//   InterstitialAd _interstitialAd;

//   BannerAd createBannerAd() {
//     return BannerAd(
//         adUnitId: BannerAd.testAdUnitId,
//         size: AdSize.banner,
//         targetingInfo: targetInfo,
//         listener: (MobileAdEvent event) => print(event));
//   }

//   InterstitialAd createInterstialAd() {
//     return InterstitialAd(
//         adUnitId: InterstitialAd.testAdUnitId,
//         targetingInfo: targetInfo,
//         listener: (MobileAdEvent event) => print(event));
//   }

//   @override
//   void initState() {
//     FirebaseAdMob.instance
//         .initialize(appId: FirebaseAdMob.testAppId);
//     _bannerAd = createBannerAd()
//       ..load()
//       ..show(anchorType: AnchorType.bottom);

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _bannerAd.dispose();
//     _interstitialAd.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 5,
//             childAspectRatio: 0.9,
//             crossAxisSpacing: 0.5,
//             mainAxisSpacing: 10.0),
//         itemBuilder: (context, i) {
//           return CircleAvatar(
//             child: IconButton(
//               icon: Icon(Icons.ac_unit),
//               onPressed: () {
//                 createInterstialAd()
//                   ..load()
//                   ..show();
//                 print("dasd");
//                 setState(() {});
//               },
//             ),
//           );
//         },
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
 

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  int _coins = 0;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
   adUnitId: InterstitialAd.testAdUnitId,
      //adUnitId: "ca-app-pub-6751441046061815/7027036028",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6751441046061815~7880597474");
    _bannerAd = createBannerAd()..load();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
        });
      }
    };
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AdMob Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                    child: const Text('SHOW BANNER'),
                    onPressed: () {
                      _bannerAd ??= createBannerAd();
                      _bannerAd
                        ..load()
                        ..show();
                    }),
                RaisedButton(
                    child: const Text('Page REfresh'),
                    onPressed: () {
                      setState(() {});
                    }),
                RaisedButton(
                    child: const Text('SHOW BANNER WITH OFFSET'),
                    onPressed: () {
                      _bannerAd ??= createBannerAd();
                      _bannerAd
                        ..load()
                        ..show(horizontalCenterOffset: 0, anchorOffset: 200);
                    }),
                RaisedButton(
                    child: const Text('REMOVE BANNER'),
                    onPressed: () {
                      _bannerAd?.dispose();
                      _bannerAd = null;
                    }),
                RaisedButton(
                  child: const Text('LOAD INTERSTITIAL'),
                  onPressed: () {
                    _interstitialAd?.dispose();
                    _interstitialAd = createInterstitialAd()..load();
                  },
                ),
                RaisedButton(
                  child: const Text('SHOW INTERSTITIAL'),
                  onPressed: () {
                    _interstitialAd?.show();
                  },
                ),
                RaisedButton(
                  child: const Text('LOAD REWARDED VIDEO'),
                  onPressed: () {
                    RewardedVideoAd.instance.load(
                        adUnitId: RewardedVideoAd.testAdUnitId,
                        targetingInfo: targetingInfo);
                  },
                ),
                RaisedButton(
                  child: const Text('SHOW REWARDED VIDEO'),
                  onPressed: () {
                    RewardedVideoAd.instance.show();
                  },
                ),
                Text("You have $_coins coins."),
              ].map((Widget button) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: button,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  runApp(const TreasureHunt());
}

class TreasureHunt extends StatelessWidget {
  const TreasureHunt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
        title: 'Skattejagt',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyText2: TextStyle(color: Colors.black),
            )),
        initialRoute: 'battery',
        routes: {
          'battery': (context) => const BatteryPage(),
          'codeword': (context) => const CodewordPage(),
          'pin': (context) => const PinPage(),
        });
  }
}

class BatteryPage extends StatefulWidget {
  const BatteryPage({Key? key}) : super(key: key);

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  var battery = Battery();

  @override
  Widget build(BuildContext context) {
    battery.onBatteryStateChanged.listen((BatteryState state) {
      if (state.name == 'charging') {
        Navigator.pushNamed(context, 'codeword');
      }
    });

    // Maybe use the Stack widget to place an AnimatedSize widget behind the battery,
    // and then the battery charges, grow the AnimatedSize widget (which has a background color...)
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/g86.png')))))),
            // TextButton(
            //   child: Text('Next'),
            //   onPressed: () {
            //     print('Pressed');
            //     Navigator.pushNamed(context, 'codeword');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class CodewordPage extends StatefulWidget {
  const CodewordPage({Key? key}) : super(key: key);
  @override
  State<CodewordPage> createState() => _CodewordPageState();
}

class _CodewordPageState extends State<CodewordPage> {
  var _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(children: [
                const Text("Indtast kodeordet",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                TextField(
                  enabled: _enabled,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (text) {
                    if (text.toLowerCase() == 'flyvemaskine') {
                      setState(() {
                        _enabled = false;
                        Navigator.pushNamed(context, 'pin');
                      });
                    }
                  },
                )
              ])),
          // TextButton(
          //   child: Text('Back'),
          //   onPressed: () {
          //     Navigator.pushNamed(context, 'battery');
          //   },
          // ),
        ])));
  }
}

class PinPage extends StatefulWidget {
  const PinPage({Key? key}) : super(key: key);
  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  var _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text("Koden er\n1670",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          // TextButton(
          //   child: Text('Back'),
          //   onPressed: () {
          //     Navigator.pushNamed(context, 'codeword');
          //   },
          // ),
        ])));
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const defaultWidth = 100.0;

class _MyHomePageState extends State<MyHomePage> {
  bool _isZoomedIn = false;
  String _buttonTile = 'Zoom In';
  double width = defaultWidth;
  var _curves = Curves.bounceIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 370),
                  width: width,
                  curve: _curves,
                  child: Image.asset('asset/images/4.jpg'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 370),
                  width: width,
                  curve: Curves.bounceIn,
                  child: Image.asset('asset/images/17.jpg'),
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _isZoomedIn = !_isZoomedIn;
                    _buttonTile = _isZoomedIn ? 'Zoom Out' : 'Zoom In';
                    _curves = _isZoomedIn ? Curves.bounceOut : Curves.bounceIn;
                    width = _isZoomedIn
                        ? MediaQuery.of(context).size.width * 0.7
                        : defaultWidth;
                  });
                },
                child: Text(_buttonTile))
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

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

class CirclePlipper extends CustomClipper<Path> {
  const CirclePlipper();
  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Color getRandomColor() => Color(0xFF000000 + Random().nextInt(0x00FFFFF));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ClipPath(
        clipper: const CirclePlipper(),
        child: TweenAnimationBuilder(
            tween: ColorTween(begin: getRandomColor(), end: _color),
            duration: const Duration(seconds: 1),
            child: Container(
              color: Colors.amber,
              height: MediaQuery.sizeOf(context).width,
              width: MediaQuery.sizeOf(context).width,
            ),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            builder: (context, color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: child,
              );
            }),
      )),
    );
  }
}

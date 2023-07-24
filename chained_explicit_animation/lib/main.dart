import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

//enmus
enum Circleside { left, right }

extension ToPath on Circleside {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case Circleside.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;

        break;

      case Circleside.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);

    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final Circleside side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _ccwAnimationController;
  late Animation<double> _ccwAnimation;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    _ccwAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _ccwAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2),
    ).animate(CurvedAnimation(
        parent: _ccwAnimationController, curve: Curves.bounceInOut));

    ///?flip
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceInOut));
//status Listener
    _ccwAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimation.value,
          end: _flipAnimation.value + pi,
        ).animate(
            CurvedAnimation(parent: _flipController, curve: Curves.bounceInOut));
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _ccwAnimation = Tween<double>(
          begin: _ccwAnimation.value,
          end: _ccwAnimation.value + -(pi / 2),
        ).animate(CurvedAnimation(
            parent: _ccwAnimationController, curve: Curves.bounceInOut));
        _ccwAnimationController
          ..reset()
          ..forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _ccwAnimationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuilt');
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () => _ccwAnimationController
    //     ..reset()
    //     ..forward(),
    // );
    _ccwAnimationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 2));
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
              animation: _ccwAnimation,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(_ccwAnimation.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                          animation: _flipAnimation,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()
                                ..rotateY(_flipAnimation.value),
                              child: ClipPath(
                                clipper: const HalfCircleClipper(
                                    side: Circleside.left),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.amber,
                                ),
                              ),
                            );
                          }),
                      AnimatedBuilder(
                          animation: _flipAnimation,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..rotateY(_flipAnimation.value),
                              child: ClipPath(
                                clipper: const HalfCircleClipper(
                                    side: Circleside.right),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  color: Colors.pink,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                );
              })),
    );
  }
}

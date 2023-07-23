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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
          child: Container(
        color: const Color(0xff24283b),
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 100, top: 100),
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
      )),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Container(
          color: const Color(0xff414868),
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.child, required this.drawer});
  final Widget child;
  final Widget drawer;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xcontrollerForChild;
  late AnimationController _xcontrollerForDrawer;

  late Animation<double> _yRotationAnimationForchild;
  late Animation<double> _yRotationAnimationForDrawer;

  @override
  void initState() {
    super.initState();
    _xcontrollerForChild = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _xcontrollerForDrawer = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _yRotationAnimationForchild =
        Tween<double>(begin: 0, end: -pi / 2).animate(_xcontrollerForChild);

    _yRotationAnimationForDrawer =
        Tween<double>(end: 0, begin: pi / 2.7).animate(_xcontrollerForDrawer);
  }

  @override
  void dispose() {
    _xcontrollerForChild.dispose();
    _xcontrollerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _xcontrollerForChild.value += details.delta.dx / maxDrag;
        _xcontrollerForDrawer.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_xcontrollerForChild.value < 0.5) {
          _xcontrollerForDrawer.reverse();
          _xcontrollerForChild.reverse();
        } else {
          _xcontrollerForDrawer.forward();
          _xcontrollerForChild.forward();
        }
      },
      child: AnimatedBuilder(
          animation:
              Listenable.merge([_xcontrollerForChild, _xcontrollerForDrawer]),
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  color: const Color(0xff1a1b26),
                ),
                Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(_xcontrollerForChild.value * maxDrag)
                      ..rotateY(_yRotationAnimationForchild.value),
                    child: widget.child),
                Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                          -screenWidth + _xcontrollerForDrawer.value * maxDrag)
                      ..rotateY(_yRotationAnimationForDrawer.value),
                    child: widget.drawer)
              ],
            );
          }),
    );
  }
}

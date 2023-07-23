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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screem'),
      ),
      body: const Center(
          child: AnimatedPrompt(
        title: 'Thanks for your order',
        subTitle: 'Order will be delivered in two days. Enjoy!',
        child: Icon(Icons.check),
      )),
    );
  }
}

class AnimatedPrompt extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget child;
  const AnimatedPrompt(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.child});

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> iconScaleAnimation;
  late Animation<double> containerScaleAnimation;
  late Animation<Offset> yDisplacementAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    yDisplacementAnimation = Tween<Offset>(
      end: const Offset(0, -0.23),
      begin: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    iconScaleAnimation = Tween<double>(
      begin: 7,
      end: 6,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    containerScaleAnimation = Tween<double>(
      begin: 2,
      end: 0.4,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller
      ..reset()
      ..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 100,
              minHeight: 100,
              maxHeight: MediaQuery.sizeOf(context).height * 0.8,
              maxWidth: MediaQuery.sizeOf(context).width * 0.8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 160,
                    ),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      widget.subTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                  child: SlideTransition(
                position: yDisplacementAnimation,
                child: ScaleTransition(
                  scale: containerScaleAnimation,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: ScaleTransition(
                      scale: iconScaleAnimation,
                      child: widget.child,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

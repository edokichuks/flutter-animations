import 'package:flutter/material.dart';
import 'package:my_animations/dashed_line_paint.dart';
import 'package:my_animations/dashed_border.dart';
import 'package:my_animations/image_slider.dart';

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
      home:  WidgetSlider(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Test Custom painter'),
            DashedLine(
              color: Colors.green,
            ),
            Text('Test Custom painter'),

            DashedBorder(
              color: Colors.amber,
              dashSpace: 5,
              dashWidth: 5,
              child: Container(
                height: 250,
                width: 400,
                color: Colors.blueGrey,
                // margin: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Text('jsjs'),
                  ],
                ),
              ),
            ),
         
            // DashedBorderContainer(
            //   color: Colors.amber,
            //   dashLength: 10,
            //   dashSpacing: 10,
            //   strokeWidth: 10,
            //   child: Container(
            //     width: 200,
            //     height: 200,
            //     color: Colors.blue,
            //     child: Center(
            //       child: Text(
            //         'Dashed Border',
            //         style: TextStyle(fontSize: 24),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            // DashedLineContainer(
            //   color: Colors.blue,
            //   dashWidth: 5.0,
            //   dashSpacing: 5.0,
            //   child: Container(
            //     width: 200,
            //     height: 100,
            //     color: Colors.red,
            //     child: Text('Dashed Line Border'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class WidgetSlider extends StatefulWidget {
  @override
  _WidgetSliderState createState() => _WidgetSliderState();
}

class _WidgetSliderState extends State<WidgetSlider> {
  int _currentIndex = 0;

  List<Widget> _slides = [
    Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Slide 1',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'Slide 2',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Slide 3',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: CarouselSlider.builder(
        itemCount: _slides.length,
        slideTransform: StackTransform(),
        unlimitedMode: true,
        slideBuilder: (index) {
          return _slides[index];
        },
        slideIndicator: CircularSlideIndicator(
          padding: EdgeInsets.only(bottom: 20),
        ),
      ),
    );
  }
}

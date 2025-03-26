import 'package:flutter/material.dart';
import 'package:tape_slider/tape_slider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('Tape Slider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selected Value: ${_currentValue.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 50),
              TapeSlider(
                initialValue: 50.0,
                minValue: 0,
                maxValue: 100,
                itemExtent: 15.0,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey.withOpacity(0.5),
                trackHeight: 200,
                trackWidth: double.infinity,
                majorTickLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                minorTickLabelStyle: TextStyle(fontSize: 14, color: Colors.white70),
                showLabels: true,
                indicatorThickness: 6.0,
                indicatorColor: Colors.red,
                tickInterval: 1,
                labelInterval: 10,
                slidingAreaExtent: 250.0,
                onValueChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}

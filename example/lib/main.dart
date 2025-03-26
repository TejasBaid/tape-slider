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
        backgroundColor: Colors.black38,
        appBar: AppBar(title: const Text('Tape Slider Example', style: TextStyle(color: Colors.white),), backgroundColor:  Colors.black38,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selected Value:',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                ' ${_currentValue.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Expanded(child:               TapeSlider(
                initialValue: 50.0,
                minValue: 0,
                maxValue: 100,
                itemExtent: 15.0,
                activeColor: Colors.white,
                inactiveColor: Colors.grey.withOpacity(0.5),
                trackHeight: 200,
                trackWidth: double.infinity,
                majorTickLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                minorTickLabelStyle: TextStyle(fontSize: 14, color: Colors.white70),
                showLabels: true,
                indicatorThickness: 10.0,
                indicatorColor: Colors.blueAccent,
                tickInterval: 1,
                labelInterval: 10,
                slidingAreaExtent: 250.0,
                onValueChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

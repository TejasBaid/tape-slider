# TapeSlider

TapeSlider is a customizable Flutter widget that provides a tape measure-like slider for selecting numeric values. It's ideal for applications that require intuitive input for measurements like weight, height, or other numeric ranges.

## Features

- Horizontal and vertical orientations
- Customizable appearance (colors, sizes, fonts)
- Configurable value range and intervals
- Smooth scrolling with snap-to-nearest-value functionality
- Efficient rendering using CustomPainter

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tape_slider: ^latest_version
```

Then run:

```
$ flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
import 'package:tape_slider/tape_slider.dart';
```

### Basic Usage

```dart
TapeSlider(
    initialValue: 65.0,
    minValue: 40.0,
    maxValue: 120.0,
    onValueChanged: (value) {
      print('Selected value: $value');
    },
)
```

<img src="https://github.com/user-attachments/assets/378de637-840f-4742-bf39-5c3eb1a999f7" width="30%"/> 
<img src="https://github.com/user-attachments/assets/2dd9efe9-a62a-43fe-aef4-7f5ef9fa8218" width="30%"/> 
<img src="https://github.com/user-attachments/assets/4253a840-56e4-4a0c-ae2e-efb713cb26e5" width="30%"/>



### Horizontal Alignment

You can align the TapeSlider horizontally within a parent widget using the `Align` widget:

```dart
Align(
    alignment: Alignment.center,
    child: TapeSlider(
        initialValue: 65.0,
        minValue: 40.0,
        maxValue: 120.0,
        onValueChanged: (value) {
          print('Selected value: $value');
        },
    ),
)
```

### Vertical Orientation

```dart
TapeSlider(
    initialValue: 65.0,
    minValue: 40.0,
    maxValue: 120.0,
    orientation: Axis.vertical,
    onValueChanged: (value) {
        print('Selected value: $value');
    },
)
```

### Customized Appearance

```dart
TapeSlider(
    initialValue: 65.0,
    minValue: 40.0,
    maxValue: 120.0,
    itemExtent: 20.0,
    activeColor: Colors.blue,
    inactiveColor: Colors.grey.withOpacity(0.5),
    indicatorColor: Colors.red,
    majorTickLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    minorTickLabelStyle: TextStyle(fontSize: 12),
    onValueChanged: (value) {
        print('Selected value: $value');
    },
)
```

## Parameters

| Parameter | Data Type | Usage |
|-----------|-----------|-------|
| initialValue | double | The starting value of the slider |
| minValue | double | The minimum value on the scale |
| maxValue | double | The maximum value on the scale |
| onValueChanged | Function(double) | Callback function when the value changes |
| orientation | Axis | Determines if the slider is horizontal or vertical |
| itemExtent | double | Width/height of each unit on the scale |
| activeColor | Color | Color of the active (selected) part of the scale |
| inactiveColor | Color | Color of the inactive part of the scale |
| trackHeight | double | Height of the slider track |
| trackWidth | double | Width of the slider track |
| majorTickLabelStyle | TextStyle | Style for major tick labels |
| minorTickLabelStyle | TextStyle | Style for minor tick labels |
| showLabels | bool | Whether to display labels on the scale |
| indicatorThickness | double | Thickness of the indicator line |
| indicatorColor | Color | Color of the indicator line |
| tickInterval | int | Interval between each tick on the scale |
| labelInterval | int | Interval between each labeled tick |
| slidingAreaExtent | double | Size of the sliding area |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


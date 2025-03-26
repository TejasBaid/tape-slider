import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tape_slider/src/tape_slider_painter.dart';

class TapeSlider extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final Function(double) onValueChanged;
  final Axis orientation;
  final double itemExtent;
  final Color activeColor;
  final Color inactiveColor;
  final double trackHeight;
  final double trackWidth;
  final TextStyle majorTickLabelStyle;
  final TextStyle minorTickLabelStyle;
  final bool showLabels;
  final double indicatorThickness;
  final Color indicatorColor;
  final int tickInterval;
  final int labelInterval;
  final double slidingAreaExtent;

  const TapeSlider({
    Key? key,
    this.initialValue = 50.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    required this.onValueChanged,
    this.orientation = Axis.horizontal,
    this.itemExtent = 15.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.trackHeight = 100.0,
    this.trackWidth = double.infinity,
    this.majorTickLabelStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    this.minorTickLabelStyle = const TextStyle(fontSize: 12, color: Colors.white70),
    this.showLabels = true,
    this.indicatorThickness = 2.0,
    this.indicatorColor = Colors.white,
    this.tickInterval = 1,
    this.labelInterval = 5,
    this.slidingAreaExtent = 250.0,
  }) : super(key: key);

  @override
  State<TapeSlider> createState() => _TapeSliderState();
}

class _TapeSliderState extends State<TapeSlider> {
  late double currentValue;
  late ScrollController _scrollController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;

    final initialOffset = (currentValue - widget.minValue) * widget.itemExtent;
    _scrollController = ScrollController(initialScrollOffset: initialOffset);

    _scrollController.addListener(_updateCurrentValue);
  }

  void _updateCurrentValue() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final newValue = widget.minValue + (offset / widget.itemExtent);

    final roundedValue = (newValue * 2).round() / 2;
    final clampedValue = math.max(widget.minValue, math.min(widget.maxValue, roundedValue));

    if (clampedValue != currentValue) {
      setState(() {
        currentValue = clampedValue;
        widget.onValueChanged(currentValue);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCurrentValue);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.orientation == Axis.horizontal;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: isHorizontal ? widget.trackWidth : widget.trackHeight,
      height: isHorizontal ? widget.trackHeight : widget.trackWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification && !_isAnimating) {
                _isAnimating = true;
                final targetOffset = ((currentValue - widget.minValue) * widget.itemExtent);
                _scrollController.animateTo(
                  targetOffset,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                ).then((_) {
                  _isAnimating = false;
                });
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: widget.orientation,
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: isHorizontal
                    ? (widget.maxValue - widget.minValue) * widget.itemExtent + screenSize.width
                    : widget.trackHeight,
                height: isHorizontal
                    ? widget.trackHeight
                    : (widget.maxValue - widget.minValue) * widget.itemExtent + screenSize.height,
                padding: EdgeInsets.symmetric(
                  horizontal: isHorizontal ? screenSize.width / 2 : 0,
                  vertical: isHorizontal ? 0 : screenSize.height / 2,
                ),
                child: CustomPaint(
                  painter: TapeScalePainter(
                    min: widget.minValue,
                    max: widget.maxValue,
                    itemExtent: widget.itemExtent,
                    orientation: widget.orientation,
                    activeColor: widget.activeColor,
                    inactiveColor: widget.inactiveColor,
                    majorTickLabelStyle: widget.majorTickLabelStyle,
                    minorTickLabelStyle: widget.minorTickLabelStyle,
                    showLabels: widget.showLabels,
                    tickInterval: widget.tickInterval,
                    labelInterval: widget.labelInterval,
                  ),
                  size: Size(
                      isHorizontal ? (widget.maxValue - widget.minValue) * widget.itemExtent : widget.trackHeight,
                      isHorizontal ? widget.trackHeight : (widget.maxValue - widget.minValue) * widget.itemExtent
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: isHorizontal ? widget.indicatorThickness : widget.slidingAreaExtent,
            height: isHorizontal ? widget.slidingAreaExtent : widget.indicatorThickness,
            decoration: BoxDecoration(
              color: widget.indicatorColor,
              border: Border.all(color: widget.indicatorColor.withOpacity(0.4)),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class AnimatedText extends StatefulWidget {
  final List<String> texts;
  final double fontSize;
  final Color color;

  const AnimatedText({
    super.key,
    required this.texts,
    this.fontSize = 20,
    this.color = Colors.black,
  });

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String _currentText = "";
  int _currentIndex = 0;
  bool _isAdding = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_isAdding) {
          _currentText =
              widget.texts[_currentIndex].substring(0, _currentText.length + 1);
          if (_currentText.length == widget.texts[_currentIndex].length) {
            _isAdding = false;
            _timer.cancel();
            Future.delayed(const Duration(seconds: 1), () {
              _startAnimation();
            });
          }
        } else {
          _currentText = _currentText.substring(0, _currentText.length - 1);
          if (_currentText.isEmpty) {
            _isAdding = true;
            _currentIndex = (_currentIndex + 1) % widget.texts.length;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentText,
      style: GoogleFonts.montserrat(
        fontSize: widget.fontSize,
        color: widget.color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

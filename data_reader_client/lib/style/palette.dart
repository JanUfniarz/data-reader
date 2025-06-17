import 'package:flutter/material.dart';

final palette = _paletteMono;

Map<Col, Color> _palette1 = {
  Col.background: Colors.grey.shade900,
  Col.primary: const Color(0xffffbe02),
  Col.secondary: const Color(0xFF024480),
  Col.text: const Color(0xC7EFEDF6),
  Col.error: Colors.red,
};

Map<Col, Color> _paletteMono = {
  Col.background: const Color(0xff14110B),
  Col.primary: const Color(0xffF4B400),
  Col.secondary: const Color(0xff4A3200),
  Col.text: const Color(0xffB2B3BD),
  Col.error: Colors.red,
};

enum Col {
  background, primary, secondary, text, error
}
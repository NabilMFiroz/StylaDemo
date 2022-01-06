import 'package:flutter/material.dart';

class ChipData {
  final String label;
  ChipData({required this.label});

  ChipData copy({String? label}) => ChipData(label: label ?? this.label);
}

import 'package:flutter/material.dart';

Color formatColor(String hexColor) => Color(int.parse('0xFF${hexColor.replaceAll('#', '')}'));

import 'package:flutter/material.dart';

class CollectionIconStyles {
  static const Map<String, Map<String, dynamic>> styles = {
    'gym': {
      'emoji': '🏋️',
      'colors': [Color(0xFFEEEDFE), Color(0xFFD5CFFE)],
      'textColor': Color(0xFF3C3489),
    },
    'breakfast': {
      'emoji': '🍳',
      'colors': [Color(0xFFFAEEDA), Color(0xFFFAC775)],
      'textColor': Color(0xFF633806),
    },
    'lunch': {
      'emoji': '🥗',
      'colors': [Color(0xFFE1F5EE), Color(0xFF9FE1CB)],
      'textColor': Color(0xFF085041),
    },
    'dinner': {
      'emoji': '🍽️',
      'colors': [Color(0xFFE6F1FB), Color(0xFFB5D4F4)],
      'textColor': Color(0xFF0C447C),
    },
    'snack': {
      'emoji': '🍎',
      'colors': [Color(0xFFFAECE7), Color(0xFFF5C4B3)],
      'textColor': Color(0xFF4A1B0C),
    },
    'salad': {
      'emoji': '🥬',
      'colors': [Color(0xFFEAF3DE), Color(0xFFC0DD97)],
      'textColor': Color(0xFF173404),
    },
    'fruit': {
      'emoji': '🍓',
      'colors': [Color(0xFFFBEAF0), Color(0xFFF4C0D1)],
      'textColor': Color(0xFF4B1528),
    },
    'drink': {
      'emoji': '🥤',
      'colors': [Color(0xFFE1F5EE), Color(0xFF9FE1CB)],
      'textColor': Color(0xFF04342C),
    },
    'diet': {
      'emoji': '🥦',
      'colors': [Color(0xFFEAF3DE), Color(0xFFC0DD97)],
      'textColor': Color(0xFF173404),
    },
    'protein': {
      'emoji': '🥩',
      'colors': [Color(0xFFFAECE7), Color(0xFFF5C4B3)],
      'textColor': Color(0xFF4A1B0C),
    },
    'vegan': {
      'emoji': '🌱',
      'colors': [Color(0xFFEAF3DE), Color(0xFFC0DD97)],
      'textColor': Color(0xFF173404),
    },
    'dessert': {
      'emoji': '🍫',
      'colors': [Color(0xFFFBEAF0), Color(0xFFF4C0D1)],
      'textColor': Color(0xFF4B1528),
    },
  };

  static Map<String, dynamic> of(String id) => styles[id] ?? styles['gym']!;

  static String emoji(String id) => of(id)['emoji'] as String;
  static List<Color> colors(String id) => of(id)['colors'] as List<Color>;
  static Color textColor(String id) => of(id)['textColor'] as Color;
}

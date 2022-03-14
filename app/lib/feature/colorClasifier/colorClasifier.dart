import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'dart:math';

extension _HsvVectors on HSVColor {
  Vector3 toVector3() {
    return Vector3(sin(radians(hue)).toDouble() / 2 + 0.5, saturation, value);
  }
}

class ColorDefinition {
  ColorDefinition({required this.name, required this.color})
      : hsvColor = HSVColor.fromColor(color);

  ColorDefinition.calculated(this.name, this.color, this.hsvColor);

  final String name;
  final Color color;
  final HSVColor hsvColor;

  double distance(HSVColor color) {
    double pow2(double x) => pow(x, 2).toDouble();
    final x1 = hsvColor.hue;
    final y1 = hsvColor.saturation;
    final z1 = hsvColor.value;

    final x2 = color.hue;
    final y2 = color.saturation;
    final z2 = color.value;

    var dh = ((x1 - x2)/360).abs();
    if(dh > 0.5)
      dh = 1.0 - dh;

    return sqrt(pow2(dh) + pow2(y1 - y2) + pow2(z1 - z2));
  }

  static Color _fromHash(String hash) {
    return Color(int.parse('FF$hash', radix: 16));
  }

  static List<ColorDefinition> clasifiedColors = [
    ColorDefinition(name: 'Black', color: _fromHash('000000')),
    ColorDefinition(name: 'Light Black', color: _fromHash('808080')),
    ColorDefinition(name: 'Blue', color: _fromHash('0000FF')),
    ColorDefinition(name: 'Dark Blue', color: _fromHash('00008B')),
    ColorDefinition(name: 'Light Blue', color: _fromHash('ADD8E6')),
    ColorDefinition(name: 'Brown', color: _fromHash('A52A2A')),
    ColorDefinition(name: 'Dark Brown', color: _fromHash('5C4033')),
    ColorDefinition(name: 'Light Brown', color: _fromHash('996600')),
    ColorDefinition(name: 'Buff', color: _fromHash('F0DC82')),
    ColorDefinition(name: 'Dark Buff', color: _fromHash('976638')),
    ColorDefinition(name: 'Light Buff', color: _fromHash('ECD9B0')),
    ColorDefinition(name: 'Cyan', color: _fromHash('00FFFF')),
    ColorDefinition(name: 'Dark Cyan', color: _fromHash('008B8B')),
    ColorDefinition(name: 'Light Cyan', color: _fromHash('E0FFFF')),
    ColorDefinition(name: 'Gold', color: _fromHash('FFD700')),
    ColorDefinition(name: 'Dark Gold', color: _fromHash('EEBC1D')),
    ColorDefinition(name: 'Light Gold', color: _fromHash('F1E5AC')),
    ColorDefinition(name: 'Goldenrod', color: _fromHash('DAA520')),
    ColorDefinition(name: 'Dark Goldenrod', color: _fromHash('B8860B')),
    ColorDefinition(name: 'Light Goldenrod', color: _fromHash('FFEC8B')),
    ColorDefinition(name: 'Gray', color: _fromHash('808080')),
    ColorDefinition(name: 'Dark Gray', color: _fromHash('404040')),
    ColorDefinition(name: 'Light Gray', color: _fromHash('D3D3D3')),
    ColorDefinition(name: 'Green', color: _fromHash('008000')),
    ColorDefinition(name: 'Dark Green', color: _fromHash('006400')),
    ColorDefinition(name: 'Light Green', color: _fromHash('90EE90')),
    ColorDefinition(name: 'Ivory', color: _fromHash('FFFFF0')),
    ColorDefinition(name: 'Dark Ivory', color: _fromHash('F2E58F')),
    ColorDefinition(name: 'Light Ivory', color: _fromHash('FFF8C9')),
    ColorDefinition(name: 'Magenta', color: _fromHash('FF00FF')),
    ColorDefinition(name: 'Dark Magenta', color: _fromHash('8B008B')),
    ColorDefinition(name: 'Light Magenta', color: _fromHash('FF77FF')),
    ColorDefinition(name: 'Mustard', color: _fromHash('FFDB58')),
    ColorDefinition(name: 'Dark Mustard', color: _fromHash('7C7C40')),
    ColorDefinition(name: 'Light Mustard', color: _fromHash('EEDD62')),
    ColorDefinition(name: 'Orange', color: _fromHash('FFA500')),
    ColorDefinition(name: 'Dark Orange', color: _fromHash('FF8C00')),
    ColorDefinition(name: 'Light Orange', color: _fromHash('D9A465')),
    ColorDefinition(name: 'Pink', color: _fromHash('FFC0CB')),
    ColorDefinition(name: 'Dark Pink', color: _fromHash('E75480')),
    ColorDefinition(name: 'Light Pink', color: _fromHash('FFB6C1')),
    ColorDefinition(name: 'Red', color: _fromHash('FF0000')),
    ColorDefinition(name: 'Dark Red', color: _fromHash('8B0000')),
    ColorDefinition(name: 'Light Red', color: _fromHash('FF3333')),
    ColorDefinition(name: 'Silver', color: _fromHash('C0C0C0')),
    ColorDefinition(name: 'Dark Silver', color: _fromHash('AFAFAF')),
    ColorDefinition(name: 'Light Silver', color: _fromHash('E1E1E1')),
    ColorDefinition(name: 'Turquoise', color: _fromHash('30D5C8')),
    ColorDefinition(name: 'Dark Turquoise', color: _fromHash('00CED1')),
    ColorDefinition(name: 'Light Turquoise', color: _fromHash('AFE4DE')),
    ColorDefinition(name: 'Violet', color: _fromHash('EE82EE')),
    ColorDefinition(name: 'Dark Violet', color: _fromHash('9400D3')),
    ColorDefinition(name: 'Light Violet', color: _fromHash('7A5299')),
    ColorDefinition(name: 'White', color: _fromHash('FFFFFF')),
    ColorDefinition(name: 'Yellow', color: _fromHash('FFFF00')),
    ColorDefinition(name: 'Dark Yellow', color: _fromHash('FFCC00')),
    ColorDefinition(name: 'Light Yellow', color: _fromHash('FFFFE0')),
  ];
}

class ColorClasifier {
  ColorClasifier(this.colorDefinitions);

  final List<ColorDefinition> colorDefinitions;

  ColorDefinition classifyColor(Color color) {
    final colorHSV = HSVColor.fromColor(color);
    final definitionDistances = colorDefinitions
        .map(
            (definition) => MapEntry(definition, definition.distance(colorHSV)))
        .toList()
      ..sort((a, b) => Comparable.compare(a.value, b.value));

    final closestDefinition = definitionDistances.first.key;

    return closestDefinition;
  }
}

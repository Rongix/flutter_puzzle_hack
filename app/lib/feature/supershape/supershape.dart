import 'dart:math';

import 'package:app/extensions/path_extensions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math.dart' as vector;

class Supershape {
  const Supershape(this.points);

  factory Supershape.fromSeed({
    required String seed,
    double angularPrecission = 0.1,
  }) {
    print('Supershape.fromSeed: $seed');
    final random = Random(seed.hashCode);
    final a = (random.nextDouble() / 4) + 0.25;
    final b = random.nextInt(8) + 1;
    final c = random.nextInt(3) + 2;
    final specialFeature1 = random.nextInt(11) > 7;
    final specialFeature2 = random.nextInt(5) > 3;

    final generatorRandom = random.nextDouble();

    return Supershape.generateShape(
      random: generatorRandom,
      angularPrecission: angularPrecission,
      numeratorBuilder: (angle) => specialFeature1 ? pow(cos(c * angle).abs(), b).toDouble() : 1,
      denominatorPower: a,
      angleMultiplier: b.toDouble(),
      anglePower: specialFeature2
          ? 2 / b
          : b > 6
              ? 4
              : b.toDouble(),
    );
  }

  factory Supershape.generateShape({
    required double random,
    required double anglePower,
    required double denominatorPower,
    double Function(double angle) numeratorBuilder = _oneFunc,
    double angularPrecission = 1.0,
    double angleMultiplier = 1.0,
  }) {
    final points = <SupershapePoint>[];

    for (var i = .0; i <= 360.0 - angularPrecission; i += angularPrecission) {
      final angle = vector.radians(i) + random;
      final sp = computePoint(
        angle: angle,
        numerator: numeratorBuilder(angle),
        angleMultiplier: angleMultiplier,
        anglePower: anglePower,
        denominatorPower: denominatorPower,
      );
      points.add(sp);
    }

    return Supershape(points);
  }

  final List<SupershapePoint> points;

  Path path(double radius) {
    final path = Path()..moveToOffset(points.first.toPoint(radius));
    for (var i = 1; i < points.length; i++) {
      path.lineToOffset(points[i].toPoint(radius));
    }
    path.close();
    return path;
  }

  static double _oneFunc(double x) => 1.0;

  static Supershape? lerp(Supershape? a, Supershape? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b!;
    if (b == null) return a;

    final points = <SupershapePoint>[];

    for (var i = 0; i < a.points.length; i++) {
      final position = SupershapePoint.lerp(a.points[i], b.points[i], t)!;
      points.add(position);
    }

    return Supershape(points);
  }

  static SupershapePoint computePoint({
    required double angle,
    required double anglePower,
    required double denominatorPower,
    double angleMultiplier = 1.0,
    double numerator = 1.0,
  }) {
    final transformedAngle = angle * angleMultiplier;

    final cosPart = pow(cos(transformedAngle).abs(), anglePower);
    final sinPart = pow(sin(transformedAngle).abs(), anglePower);

    final denominator = pow(cosPart + sinPart, denominatorPower);
    final result = numerator / denominator;

    return SupershapePoint(result, angle);
  }
}

class SupershapePoint {
  const SupershapePoint(this.shapeValue, this.angle);

  final double shapeValue;
  final double angle;

  Offset toPoint(double radius) {
    final px = radius * shapeValue * cos(angle);
    final py = radius * shapeValue * sin(angle);

    return Offset(px, py);
  }

  static SupershapePoint? lerp(SupershapePoint? a, SupershapePoint? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b!;
    if (b == null) return a;

    return SupershapePoint(
      lerpDouble(a.shapeValue, b.shapeValue, t),
      lerpDouble(a.angle, b.angle, t),
    );
  }
}

class SupershapeTween extends Tween<Supershape?> {
  SupershapeTween({
    Supershape? begin,
    Supershape? end,
  }) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  Supershape? lerp(double t) => Supershape.lerp(begin, end, t);
}

double lerpDouble(double a, double b, double t) {
  return a * (1.0 - t) + b * t;
}

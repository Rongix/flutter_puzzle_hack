import 'dart:math';

import 'package:app/extensions/path_extensions.dart';
import 'package:app/feature/supershape/supershape_config.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math.dart' as vector;

typedef DoubleBuilder = double Function(double value);

class Supershape {
  const Supershape(this.points, this.angleOffset, this.config);

  factory Supershape.fromSeed({
    required String seed,
    double angularPrecission = 1.0,
  }) {
    print('Supershape.fromSeed: $seed');
    final random = Random(seed.hashCode);
    final config = SupershapeConfig.seeds[random.nextInt(SupershapeConfig.seeds.length)];

    return Supershape.fromConfig(
        config: config, angularPrecission: angularPrecission, angleOffset: random.nextDouble() + 0.5);

    /// Totally random shape generation. Renerated shapes are a bit too random
    /// Left for a reference
    // return Supershape.generateShape(
    //   angleOffset: generatorRandom,
    //   angularPrecission: angularPrecission,
    //   numeratorBuilder: (angle) => specialFeature1 ? pow(cos(c * angle).abs(), b).toDouble() : 1,
    //   denominatorPower: a,
    //   angleMultiplier: b.toDouble(),
    //   anglePower: specialFeature2
    //       ? 2 / b
    //       : b > 6
    //           ? 4
    //           : b.toDouble(),
    // );
  }

  factory Supershape.fromConfig({
    required SupershapeConfig config,
    required double angleOffset,
    double angularPrecission = 1.0,
  }) {
    final points = <SupershapePoint>[];

    for (var i = .0; i <= 360.0 - angularPrecission; i += angularPrecission) {
      final angle = vector.radians(i) + angleOffset;
      final sp = computePoint(
        angle: angle,
        numerator: config.numeratorBuilder(angle),
        angleMultiplier: config.angleMultiplier,
        anglePower: config.anglePower,
        denominatorPower: config.denominatorPower,
      );
      points.add(sp);
    }

    return Supershape(points, angleOffset, config);
  }

  final List<SupershapePoint> points;
  final double angleOffset;
  final SupershapeConfig config;

  Path path(double radius) {
    final path = Path()..moveToOffset(points.first.toPoint(radius, angleOffset));
    final angularPrecission = 360 / points.length;
    for (var i = 1; i < points.length; i++) {
      path.lineToOffset(points[i].toPoint(
        radius,
        vector.radians(angularPrecission * i) + angleOffset,
      ));
    }
    path.close();
    return path;
  }

  static Supershape? lerp(Supershape? a, Supershape? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b!;
    if (b == null) return a;

    final points = <SupershapePoint>[];

    for (var i = 0; i < a.points.length; i++) {
      final position = SupershapePoint.lerp(a.points[i], b.points[i], t)!;
      points.add(position);
    }

    return Supershape(points, lerpDouble(a.angleOffset, b.angleOffset, t), b.config);
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

    return SupershapePoint(result);
  }
}

class SupershapePoint {
  const SupershapePoint(this.shapeValue);

  final double shapeValue;

  Offset toPoint(double radius, double angle) {
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

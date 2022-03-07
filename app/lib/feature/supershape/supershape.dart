import 'dart:math';

import 'package:app/extensions/path_extensions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math.dart' as vector;

class Supershape {
  const Supershape(this.points, this.path);

  factory Supershape.fromSeed({
    required String seed,
    required double radius,
    double angularPrecission = 0.1,
  }) {
    print('Supershape.fromSeed: $seed');
    final random = Random(seed.hashCode);
    final a = (random.nextDouble() / 4) + 0.25;
    final b = random.nextInt(8) + 1;
    final c = random.nextInt(3) + 2;
    final specialFeature1 = random.nextInt(11) > 7;
    final specialFeature2 = random.nextInt(5) > 3;

    return Supershape.generateShape(
      angularPrecission: angularPrecission,
      radius: radius,
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
    required double radius,
    required double anglePower,
    required double denominatorPower,
    double Function(double angle) numeratorBuilder = _oneFunc,
    double angularPrecission = 1.0,
    double angleMultiplier = 1.0,
  }) {
    final path = Path();
    final positions = <Offset>[];

    for (var i = .0; i <= 360.0 - angularPrecission; i += angularPrecission) {
      final angle = vector.radians(i) * angleMultiplier;
      final point = computePoint(
        angle: angle,
        shapeRadius: radius,
        numerator: numeratorBuilder(angle),
        angleMultiplier: angleMultiplier,
        anglePower: anglePower,
        denominatorPower: denominatorPower,
      );
      // Optionaly move it out of the loop
      positions.add(point);
      i == 0 ? path.moveToOffset(point) : path.lineToOffset(point);
    }

    return Supershape(positions, path..close());
  }

  final List<Offset> points;
  final Path path;

  static double _oneFunc(double x) => 1.0;

  static Supershape? lerp(Supershape? a, Supershape? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b!;
    if (b == null) return a;

    final path = Path();
    final points = <Offset>[];

    for (var i = 0; i < a.points.length; i++) {
      final position = Offset.lerp(a.points[i], b.points[i], t)!;

      // Optionaly move it out of the loop
      points.add(position);
      i == 0 ? path.moveToOffset(position) : path.lineToOffset(position);
    }

    return Supershape(points, path..close());
  }

  /// angle - in radians
  static Offset computePoint({
    required double angle,
    required double anglePower,
    required double denominatorPower,
    required double shapeRadius,
    double angleMultiplier = 1.0,
    double numerator = 1.0,
  }) {
    final transformedAngle = angle * angleMultiplier;

    final cosPart = pow(cos(transformedAngle).abs(), anglePower);
    final sinPart = pow(sin(transformedAngle).abs(), anglePower);

    final denominator = pow(cosPart + sinPart, denominatorPower);
    final result = numerator / denominator;

    final px = shapeRadius * result * cos(angle);
    final py = shapeRadius * result * sin(angle);

    return Offset(px, py);
  }
}

class SupershapePoint {}

class SupershapeTween extends Tween<Supershape?> {
  SupershapeTween({
    Supershape? begin,
    Supershape? end,
  }) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  Supershape? lerp(double t) => Supershape.lerp(begin, end, t);
}

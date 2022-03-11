import 'dart:math' as math;

import 'package:app/feature/supershape/supershape.dart';

double _doubleBuilderDefault(double val) => 1;

class SupershapeConfig {
  const SupershapeConfig({
    this.name = '',
    this.denominatorPower = 1,
    this.anglePower = 1,
    this.angleMultiplier = 1,
    this.numeratorBuilder = _doubleBuilderDefault,
    this.angleOffset = 0,
  });

  final String name;
  final double angleOffset;
  final DoubleBuilder numeratorBuilder;
  final double denominatorPower;
  final double angleMultiplier;
  final double anglePower;

  static List<SupershapeConfig> seeds = [
    seedRhombSquircle,
    seedPillow,
    seedPeas,
    seedRoundSquircle,
    seedSquareSquircle,
    seedBall,
    seedSquare,
    seedSeed,
    seedStretchedSeed,
    seedGuitarPlectrum,
    seedRhomb,
    seedEvilStar5,
    seedEvilStar6,
    seedEvilStar7,
    seedEvilStar8,
    seedDroplet,
    seedWooblyTriangleCookie,
    seedStar4,
    seedStar5,
    seedStar6,
    seedStar7,
    seedStar8,
    seedMushySquircle,
    seedPentagonSmooth,
    seedHexagonSmooth,
    seedOctaSmooth,
    seedHeptaSmooth,
    seedVanillaFlower,
    seedAquaStar,
    seedAquaPentagon,
    seedSmoothHeptaBadge,
    seedInSquare,
    seedDorotis,
    seedFlower1,
    seedFlower2,
    seedFlower3,
    seedFlower4,
    seedFlower5,
    seedWizardStar,
    seedWizardShield,
    seedWizardShieldRound,
    seedPlanetoid,
  ];

  // 1
  static SupershapeConfig seedRhombSquircle = SupershapeConfig(
    name: 'RhombSquircle',
    numeratorBuilder: (_) => 1.35,
    anglePower: 1.4,
    denominatorPower: 1 / 1.4,
  );

  // 2
  static SupershapeConfig seedPillow = SupershapeConfig(
    name: 'Pillow',
    numeratorBuilder: (_) => 1.4,
    anglePower: 1 / 1.6,
    denominatorPower: 1 / 1.6,
  );

  // 3
  static SupershapeConfig seedPeas = SupershapeConfig(
    name: 'Peas',
    numeratorBuilder: (_) => 1.35,
    anglePower: 1.6,
    denominatorPower: 1 / 1.6,
  );

  // 4
  static SupershapeConfig seedRoundSquircle = SupershapeConfig(
    name: 'RoundSquircle',
    numeratorBuilder: (_) => 1.35,
    anglePower: 3,
    denominatorPower: 1 / 3,
  );

  // 5
  static SupershapeConfig seedSquareSquircle = SupershapeConfig(
    name: 'SquareSquircle',
    numeratorBuilder: (_) => 1.4,
    anglePower: 5,
    denominatorPower: 1 / 5,
  );

  // 6
  static SupershapeConfig seedBall = SupershapeConfig(
    name: 'Ball',
    numeratorBuilder: (_) => 1.4,
    angleMultiplier: 0,
  );

  // 7
  static SupershapeConfig seedSquare = SupershapeConfig(
    name: 'Square',
    numeratorBuilder: (_) => 1.3,
    anglePower: 50,
    denominatorPower: 1 / 50,
  );

  // 8
  static SupershapeConfig seedSeed = SupershapeConfig(
    name: 'Grapes',
    numeratorBuilder: (_) => 1.6,
    angleMultiplier: 1 / 4,
  );

  // 9
  static SupershapeConfig seedStretchedSeed = SupershapeConfig(
    name: 'Peans',
    numeratorBuilder: (_) => 1.4,
    angleMultiplier: 2 / 4,
  );

  // 10
  static SupershapeConfig seedGuitarPlectrum = SupershapeConfig(
    name: 'Corns',
    numeratorBuilder: (_) => 1.7,
    angleMultiplier: 3 / 4,
  );

  // 11
  static SupershapeConfig seedRhomb = SupershapeConfig(
    name: 'Rhomb',
    numeratorBuilder: (_) => 1.7,
  );

  // 12
  static SupershapeConfig seedEvilStar5 = SupershapeConfig(
    name: 'Sugar',
    numeratorBuilder: (_) => 1.3,
    angleMultiplier: 5 / 4,
  );

  // 13
  static SupershapeConfig seedEvilStar6 = SupershapeConfig(
    name: 'Bamboo forest',
    numeratorBuilder: (_) => 1.7,
    angleMultiplier: 6 / 4,
  );

  // 14
  static SupershapeConfig seedEvilStar7 = SupershapeConfig(
    name: 'Turtles',
    numeratorBuilder: (_) => 1.65,
    angleMultiplier: 7 / 4,
  );

  // 15
  static SupershapeConfig seedEvilStar8 = SupershapeConfig(
    name: 'Clemantis',
    numeratorBuilder: (_) => 1.65,
    angleMultiplier: 8 / 4,
  );

  // 16
  static SupershapeConfig seedDroplet = SupershapeConfig(
    name: 'Water',
    numeratorBuilder: (_) => 2.2,
    angleMultiplier: 1 / 4,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 17
  static SupershapeConfig seedWooblyTriangleCookie = SupershapeConfig(
    name: 'WooblyTriangleCookie',
    numeratorBuilder: (_) => 1.75,
    angleMultiplier: 3 / 4,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 18
  static SupershapeConfig seedStar4 = SupershapeConfig(
    name: 'Mustard',
    numeratorBuilder: (_) => 1.55,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 18
  static SupershapeConfig seedStar5 = SupershapeConfig(
    name: 'Wheat',
    numeratorBuilder: (_) => 2.5,
    angleMultiplier: 5 / 4,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 18
  static SupershapeConfig seedStar6 = SupershapeConfig(
    name: 'Star6',
    numeratorBuilder: (_) => 1.65,
    angleMultiplier: 6 / 4,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 18
  static SupershapeConfig seedStar7 = SupershapeConfig(
    name: 'Chestnut',
    numeratorBuilder: (_) => 2.5,
    angleMultiplier: 7 / 4,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 19
  static SupershapeConfig seedStar8 = SupershapeConfig(
    name: 'Star8',
    numeratorBuilder: (_) => 2.1,
    angleMultiplier: 8 / 4,
    anglePower: 0.5,
    denominatorPower: 1 / 0.5,
  );

  // 20
  static SupershapeConfig seedMushySquircle = SupershapeConfig(
    name: 'MushySquircle',
    numeratorBuilder: (_) => 1.3,
    anglePower: 15,
    denominatorPower: 1 / 30,
  );

  // 21
  static SupershapeConfig seedPentagonSmooth = SupershapeConfig(
    name: 'Dog',
    numeratorBuilder: (_) => 1.25,
    angleMultiplier: 5 / 4,
    anglePower: 15,
    denominatorPower: 1 / 30,
  );

  // 21
  static SupershapeConfig seedHexagonSmooth = SupershapeConfig(
    name: 'HexagonSmooth',
    numeratorBuilder: (_) => 1.15,
    angleMultiplier: 6 / 4,
    anglePower: 15,
    denominatorPower: 1 / 30,
  );

  // 22
  static SupershapeConfig seedOctaSmooth = SupershapeConfig(
    name: 'OctaSmooth',
    numeratorBuilder: (_) => 1.25,
    angleMultiplier: 7 / 4,
    anglePower: 15,
    denominatorPower: 1 / 30,
  );

  // 23
  static SupershapeConfig seedHeptaSmooth = const SupershapeConfig(
    name: 'HeptaSmooth',
    angleMultiplier: 8 / 4,
    anglePower: 15,
    denominatorPower: 1 / 30,
  );

  // 24
  static SupershapeConfig seedVanillaFlower = SupershapeConfig(
    name: 'Patrick',
    numeratorBuilder: (_) => 0.7,
    angleMultiplier: 1.25,
    anglePower: 7,
    denominatorPower: 1 / 2,
  );

  // 25
  static SupershapeConfig seedAquaStar = SupershapeConfig(
    name: 'AquaStar',
    numeratorBuilder: (_) => 0.22,
    angleMultiplier: 1.25,
    anglePower: 13,
    denominatorPower: 1 / 2,
  );

  // 26
  static SupershapeConfig seedAquaPentagon = const SupershapeConfig(
    name: 'AquaPentagon',
    angleMultiplier: 1.25,
    anglePower: 4,
    denominatorPower: 1 / 4,
  );

  // 27
  static SupershapeConfig seedSmoothHeptaBadge = const SupershapeConfig(
    name: 'SmoothHeptaBadge',
    angleMultiplier: 1.75,
    anglePower: 6,
    denominatorPower: 1 / 10,
  );

  // 28
  static SupershapeConfig seedInSquare = const SupershapeConfig(
    name: 'InSquare',
    anglePower: 15,
    denominatorPower: 1 / 12,
  );

  // 30
  static SupershapeConfig seedDorotis = const SupershapeConfig(
    name: 'Dorotis',
    angleMultiplier: 0.75,
    anglePower: 10,
    denominatorPower: 1 / 4.5,
  );

  // 31
  static SupershapeConfig seedFlower1 = SupershapeConfig(
    name: 'Flower11A',
    numeratorBuilder: (angle) => 1.6 * math.pow(math.cos(angle * 2.5).abs(), 1 / 3).toDouble(),
    angleMultiplier: 2.5,
    anglePower: 3,
    denominatorPower: 1 / 3,
  );

  // 32
  static SupershapeConfig seedFlower2 = SupershapeConfig(
    name: 'Flower11B',
    numeratorBuilder: (angle) => 2 * math.pow(math.cos(angle * 2.5).abs(), 1 / 3).toDouble(),
    angleMultiplier: 2.5,
    denominatorPower: 1 / 3,
  );

  // 33
  static SupershapeConfig seedFlower3 = SupershapeConfig(
    name: 'Clovers',
    numeratorBuilder: (angle) => 1.6 * math.pow(math.cos(angle * 2.5).abs(), 1 / 5).toDouble(),
    angleMultiplier: 2.5,
    denominatorPower: 1 / 5,
  );

  // 34
  static SupershapeConfig seedFlower4 = SupershapeConfig(
    name: 'Flower11D',
    numeratorBuilder: (angle) => 2.2 * math.pow(math.cos(angle * 2.5).abs(), 1 / 5).toDouble(),
    angleMultiplier: 2.5,
  );

  // 35
  static SupershapeConfig seedFlower5 = SupershapeConfig(
    name: 'Flower11E',
    numeratorBuilder: (angle) => 2.2 * math.pow(math.cos(angle * 2.5).abs(), 1 / 2).toDouble(),
    angleMultiplier: 2.5,
  );

  // 36
  static SupershapeConfig seedWizardStar = SupershapeConfig(
    name: 'WizardStar',
    numeratorBuilder: (_) => 1.24,
    angleMultiplier: 1.25,
    anglePower: 3,
    denominatorPower: 1 / 3,
  );

  // 37
  static SupershapeConfig seedWizardShield = SupershapeConfig(
    name: 'WizardShield',
    numeratorBuilder: (_) => 1.4,
    angleMultiplier: 1.25,
    denominatorPower: 1 / 3,
  );

  // 38
  static SupershapeConfig seedWizardShieldRound = SupershapeConfig(
    name: 'WizardShieldRound',
    numeratorBuilder: (_) => 1.4,
    angleMultiplier: 1.25,
    denominatorPower: 1 / 5,
  );

  // 39
  static SupershapeConfig seedPlanetoid = SupershapeConfig(
    name: 'Planetoid',
    numeratorBuilder: (_) => 1.355,
    angleMultiplier: 2.5,
    anglePower: 5,
    denominatorPower: 1 / 5,
  );
}

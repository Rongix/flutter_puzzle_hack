import 'dart:ui';

import 'package:app/feature/color_clasifier/color_clasifier.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// *Singleton (registered in getIt)
class ThemeCubit extends Cubit<ThemeSingletonState> {
  ThemeCubit() : super(ThemeSingletonState.fallbackTheme());

  void changeTheme(String seed) {
    emit(ThemeSingletonState.fromSeed(seed));
  }
}

class ThemeSingletonState extends Equatable {
  const ThemeSingletonState(
      this.palette, this.lightMode, this.darkMode, this.name);

  factory ThemeSingletonState.fallbackTheme() =>
      ThemeSingletonState.fromSeed('ABCDEFGHIJKLMNPO');

  factory ThemeSingletonState.fromSeed(String seed) {
    final puzzleHashCode = seed.hashCode;
    final palette = CorePalette.of(puzzleHashCode);

    final colorDefnition = ColorClasifier(ColorDefinition.clasifiedColors)
        .classifyColor(Color(palette.primary.get(50)));

    return ThemeSingletonState(palette, lighModeFromPalette(palette),
        darkModeFromPaletter(palette), colorDefnition.name);
  }

  final String name;
  final CorePalette palette;
  final ThemeData lightMode;
  final ThemeData darkMode;

  static ThemeData lighModeFromPalette(CorePalette palette) {
    return ThemeData(
      fontFamily: 'Oswald',
      brightness: Brightness.light,
      primaryColor: Color(palette.primary.get(50)),
      scaffoldBackgroundColor: Color(palette.neutral.get(95)),
      backgroundColor: Color(palette.primary.get(98)),
      shadowColor: Color(palette.neutral.get(10)),
      cardColor: Color(palette.neutralVariant.get(95)),
      colorScheme: ColorScheme.light(
        primary: Color(palette.primary.get(60)),
        primaryContainer: Color(palette.primary.get(67)),
      ),
      iconTheme: IconThemeData(
        color: Color(palette.tertiary.get(40)),
      ),
      textTheme: TextTheme(
        headline5: headline5(Color(palette.neutral.get(30))),
        subtitle1: subtitle1(Color(palette.tertiary.get(40))),
        bodyText2: bodyText2(Color(palette.neutral.get(40))),
        button: button(),
      ),
      primaryTextTheme: TextTheme(
        headline6: headline6Primary(Color(palette.primary.get(99))),
      ),
      outlinedButtonTheme: outlinedButtonTheme(palette.tertiary, isDark: false),
    );
  }

  static ThemeData darkModeFromPaletter(CorePalette palette) {
    return ThemeData(
      fontFamily: 'Oswald',
      brightness: Brightness.dark,
      primaryColor: Color(palette.primary.get(50)),
      scaffoldBackgroundColor: Color(palette.neutral.get(10)),
      backgroundColor: Color(palette.neutralVariant.get(05)),
      cardColor: Color(palette.neutral.get(05)),
      colorScheme: ColorScheme.dark(
        primary: Color(palette.primary.get(35)),
        primaryContainer: Color(palette.primary.get(25)),
        tertiary: Color(palette.tertiary.get(20)),
        tertiaryContainer: Color(palette.tertiary.get(30)),
      ),
      iconTheme: IconThemeData(
        color: Color(palette.tertiary.get(90)),
      ),
      textTheme: TextTheme(
        headline5: headline5(Color(palette.neutral.get(97))),
        subtitle1: subtitle1(Color(palette.tertiary.get(90))),
        bodyText2: bodyText2(Color(palette.neutral.get(90))),
        button: button(),
      ),
      primaryTextTheme: TextTheme(
        headline6: headline6Primary(Color(palette.neutralVariant.get(97))),
      ),
      outlinedButtonTheme: outlinedButtonTheme(palette.tertiary, isDark: true),
    );
  }

  static const List<FontFeature> monospaceFont = [
    FontFeature.proportionalFigures()
  ];

  static TextStyle headline5(Color color) => TextStyle(
      color: color,
      fontSize: 28,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w900);

  static TextStyle subtitle1(Color color) => TextStyle(
      color: color,
      fontSize: 18,
      letterSpacing: 1.5,
      height: 1,
      fontWeight: FontWeight.w600);

  static TextStyle bodyText2(Color color) => TextStyle(
      color: color,
      fontSize: 16,
      letterSpacing: 1.5,
      fontWeight: FontWeight.w600);

  static TextStyle button() => const TextStyle(height: 1.3, fontSize: 14);

  /// Primary text styles

  static TextStyle headline6Primary(Color color) => TextStyle(
      color: color, fontWeight: FontWeight.w900, fontFeatures: monospaceFont);

  /// Buttons

  static OutlinedButtonThemeData outlinedButtonTheme(TonalPalette tonalPalette,
      {required bool isDark}) {
    final overlay = isDark
        ? Color(tonalPalette.get(30)).withOpacity(0.1)
        : Color(tonalPalette.get(80)).withOpacity(0.1);
    final foreground =
        isDark ? Color(tonalPalette.get(90)) : Color(tonalPalette.get(40));

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) =>
            const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
        shape: MaterialStateProperty.resolveWith((states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
        overlayColor: MaterialStateProperty.resolveWith((states) => overlay),
        foregroundColor:
            MaterialStateProperty.resolveWith((states) => foreground),
      ),
    );
  }

  @override
  List<Object?> get props => [palette];
}

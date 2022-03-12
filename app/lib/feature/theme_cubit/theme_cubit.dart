import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// *Singleton (registered in getIt)
class ThemeCubit extends Cubit<ThemeCubitState> {
  ThemeCubit() : super(ThemeCubitState.fallbackTheme());

  void changeTheme(String seed) {
    emit(ThemeCubitState.fromSeed(seed));
  }
}

class ThemeCubitState extends Equatable {
  const ThemeCubitState(this.palette, this.lightMode, this.darkMode);

  factory ThemeCubitState.fallbackTheme() => ThemeCubitState.fromSeed('ABCDEFGHIJKLMNOP');

  factory ThemeCubitState.fromSeed(String seed) {
    final puzzleHashCode = seed.hashCode;
    print(puzzleHashCode);
    final palette = CorePalette.of(puzzleHashCode);

    return ThemeCubitState(palette, lighModeFromPalette(palette), darkModeFromPaletter(palette));
  }

  final CorePalette palette;
  final ThemeData lightMode;
  final ThemeData darkMode;

  static ThemeData lighModeFromPalette(CorePalette palette) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(palette.neutral.get(95)),
      backgroundColor: Color(palette.primary.get(97)),
      shadowColor: Color(palette.neutral.get(10)),
      colorScheme: ColorScheme.light(
        primary: Color(palette.primary.get(60)),
        primaryContainer: Color(palette.primary.get(67)),
      ),
      iconTheme: IconThemeData(
        color: Color(palette.neutral.get(50)),
      ),
      textTheme: TextTheme(
        caption: TextStyle(
          color: Color(palette.neutral.get(50)),
          fontSize: 10,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: Color(palette.primary.get(99)),
          shadows: [
            Shadow(
              offset: const Offset(2.0, 2.0),
              blurRadius: 5.0,
              color: Color(palette.tertiary.get(40)),
            ),
          ],
          fontWeight: FontWeight.w900,
          fontFeatures: const [FontFeature.proportionalFigures()],
        ),
      ),
    );
  }

  static ThemeData darkModeFromPaletter(CorePalette palette) {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(palette.neutral.get(10)),
      backgroundColor: Color(palette.primary.get(03)),
      colorScheme: ColorScheme.dark(
        primary: Color(palette.primary.get(35)),
        primaryContainer: Color(palette.primary.get(25)),
        tertiary: Color(palette.tertiary.get(20)),
        tertiaryContainer: Color(palette.tertiary.get(30)),
      ),
      iconTheme: IconThemeData(
        color: Color(palette.neutral.get(80)),
      ),
      fontFamily: 'Oswald',
      textTheme: TextTheme(
        headline5: TextStyle(
          color: Color(palette.neutral.get(97)),
          fontSize: 28,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w900,
        ),
        subtitle1: TextStyle(
          color: Color(palette.tertiary.get(90)),
          fontSize: 18,
          letterSpacing: 1.5,
          height: 1,
          fontWeight: FontWeight.w600,
        ),
        bodyText2: TextStyle(
          color: Color(palette.neutral.get(90)),
          fontSize: 16,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
        button: TextStyle(
          color: Color(palette.neutral.get(0)),
          height: 1.2,
          fontSize: 14,
        ),
      ),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: Color(palette.neutralVariant.get(97)),
          fontWeight: FontWeight.w900,
          fontFeatures: const [FontFeature.proportionalFigures()],
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
              (states) => const EdgeInsets.symmetric(vertical: 14, horizontal: 24)),
          shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
          overlayColor:
              MaterialStateProperty.resolveWith((states) => Color(palette.tertiary.get(30)).withOpacity(0.1)),
          foregroundColor: MaterialStateProperty.resolveWith((states) => Color(palette.tertiary.get(90))),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [palette];
}

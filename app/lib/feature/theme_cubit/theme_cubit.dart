import 'package:crypto/crypto.dart' as crypto;
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
    final puzzleHashCode = crypto.md5.convert(seed.codeUnits).hashCode;
    final palette = CorePalette.of(puzzleHashCode);

    return ThemeCubitState(palette, lighModeFromPalette(palette), darkModeFromPaletter(palette));
  }

  final CorePalette palette;
  final ThemeData lightMode;
  final ThemeData darkMode;

  static ThemeData lighModeFromPalette(CorePalette palette) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(palette.neutral.get(90)),
      backgroundColor: Color(palette.neutral.get(60)),
      shadowColor: Color(palette.neutral.get(10)),
      cardTheme: CardTheme(
        color: Color(palette.primary.get(60)),
        margin: EdgeInsets.zero,
        elevation: 15,
        shadowColor: Color(palette.tertiary.get(80)),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Color(palette.neutral.get(95)),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  static ThemeData darkModeFromPaletter(CorePalette palette) {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(palette.neutral.get(10)),
      backgroundColor: Color(palette.neutral.get(40)),
      splashColor: Color(palette.neutral.get(40)).withOpacity(0.3),
      highlightColor: Colors.transparent,
      hoverColor: Color(palette.neutral.get(20)).withOpacity(0.5),

      // shadowColor: Color(palette.neutral.get(10)),
      cardTheme: CardTheme(
        color: Color(palette.primary.get(20)),
        margin: EdgeInsets.zero,
        elevation: 15,
        shadowColor: Color(palette.tertiary.get(20)),
      ),
      iconTheme: IconThemeData(
        color: Color(palette.neutral.get(80)),
      ),
      textTheme: TextTheme(
          headline6: TextStyle(
            color: Color(palette.neutral.get(90)),
            fontWeight: FontWeight.w900,
          ),
          caption: TextStyle(
            color: Color(palette.neutral.get(70)),
            fontSize: 10,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  @override
  List<Object?> get props => [palette];
}

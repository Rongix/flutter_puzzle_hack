import 'package:app/feature/theme_cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

import '../feature/sixteen_puzzle/sixteen_puzzle_logic.dart';

final getIt = GetIt.I;

void setupInjection() {
  getIt
    ..registerFactory<SixteenPuzzleLogic>(SixteenPuzzleLogic.new)
    ..registerSingleton<ThemeCubit>(ThemeCubit());
}

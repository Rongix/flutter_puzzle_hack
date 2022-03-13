import 'package:get_it/get_it.dart';
import 'package:sixteen_puzzle/slide_puzzle.dart';

import '../feature/core/puzzle_seed_cubit.dart';
import '../feature/core/theme_cubit.dart';

final getIt = GetIt.I;

void setupInjection() {
  const sixteenPuzzleGenerator = SixteenPuzzleGenerator();

  getIt
    ..registerSingleton<ThemeCubit>(ThemeCubit())
    ..registerSingleton<SixteenPuzzleGenerator>(sixteenPuzzleGenerator)
    ..registerSingleton<PuzzleSeedCubit>(PuzzleSeedCubit(sixteenPuzzleGenerator));
}

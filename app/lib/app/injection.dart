import 'package:app/app/navigator_cubit.dart';
import 'package:get_it/get_it.dart';

import '../feature/sixteen_puzzle/sixteen_puzzle_logic.dart';

final getIt = GetIt.I;

void injection() {
  getIt
    ..registerFactory<SixteenPuzzleLogic>(SixteenPuzzleLogic.new)
    ..registerLazySingleton<NavigatorCubit>(NavigatorCubit.new);
}

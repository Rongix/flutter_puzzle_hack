import 'package:app/feature/theme_cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

void setupInjection() {
  getIt.registerSingleton<ThemeCubit>(ThemeCubit());
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../widgets/fx/fx_on_action_scale.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text('404',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 60)),
                  Text('This page does not exist',
                      style: Theme.of(context).textTheme.headline5),
                  Text('Go back or generate new random puzzle',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 32),
                  FxOnActionScale(
                    child: OutlinedButton.icon(
                      icon: const Icon(MdiIcons.seed),
                      label: const Text('Generate new random puzzle!'),
                      onPressed: () => GoRouter.of(context).go('/r/puzzle'),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ],
          ),
        ),
      );
}

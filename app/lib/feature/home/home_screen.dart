import 'dart:math';

import 'package:app/feature/supershape/supershape_painter.dart';
import 'package:app/widgets/fx/fx_on_action_scale.dart';
import 'package:app/widgets/layout/autolayout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../supershape/supershape.dart';
import '../supershape/supershape_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (_, cstr) {
              return ListView(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: cstr.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          'Puzzle Challenge',
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Naturally wild puzzle',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                        FxOnActionScale(
                          onTap: () => GoRouter.of(context).go('/r/puzzle'),
                          child: Transform.rotate(
                            angle: pi,
                            child: CustomPaint(
                              size: Size(150, 150),
                              painter: SupershapePainter(
                                supershape: Supershape.fromConfig(
                                  angleOffset: 0,
                                  config: SupershapeConfig.seedDorotis,
                                ),
                                color1: Theme.of(context).primaryColor,
                                color2: Theme.of(context).backgroundColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        PuzzleControlsInstruction(),
                        const SizedBox(height: 60),
                        const SizedBox(height: 32),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class PuzzleControlsInstruction extends StatelessWidget {
  const PuzzleControlsInstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UniversalAutoLayout(
      onSmall: (_, __) {
        return Wrap(
            direction: Axis.vertical,
            spacing: 32,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildKeyboardInfo(context),
              _buildPointerInfo(context),
            ]);
      },
      onMedium: (cstr, __) {
        return buildBigLayout(cstr, context);
      },
      onLarge: (cstr, __) {
        return buildBigLayout(cstr, context);
      },
    );
  }

  Widget buildBigLayout(BoxConstraints cstr, BuildContext context) {
    return Wrap(
      spacing: 32,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: cstr.maxWidth / 2 - 16),
            child: _buildKeyboardInfo(context)),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: cstr.maxWidth / 2 - 16),
          child: _buildPointerInfo(context),
        ),
      ],
    );
  }

  Widget _buildKeyboardInfo(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Press shift to move\nwhole row/column',
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(MdiIcons.arrowUpBoldBoxOutline),
            const SizedBox(width: 16),
            Column(
              children: [
                Wrap(
                  children: const [
                    Icon(MdiIcons.alphaABox),
                    Icon(MdiIcons.alphaWBox),
                    Icon(MdiIcons.alphaSBox),
                    Icon(MdiIcons.alphaDBox),
                  ],
                ),
                Wrap(
                  children: const [
                    Icon(MdiIcons.arrowLeftBoldBox),
                    Icon(MdiIcons.arrowUpBoldBox),
                    Icon(MdiIcons.arrowDownBoldBox),
                    Icon(MdiIcons.arrowRightBoldBox),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPointerInfo(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        Text(
          'Click any tile/row/column\nto move it into blank',
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(MdiIcons.gestureTap),
            SizedBox(width: 32),
            Icon(MdiIcons.cursorDefaultClick),
          ],
        ),
      ],
    );
  }
}

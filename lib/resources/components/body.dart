import 'package:flutter/material.dart';
import 'package:stage/stage.dart';

class StageBody<T> extends StatelessWidget {
  const StageBody({
    required this.children,
    this.customBackground,
  });

  final Color Function(ThemeData)? customBackground;
  // TODO: convert to builder
  final Map<T, Widget> children;

  @override
  Widget build(BuildContext context) {
    return StageBuild.offMainPagesData<T>(
      (_, __, orderedPages, page) => RadioPageTransition<T?>(
        page: page,
        builder: (context, value) => children[value]!,
        orderedPages: orderedPages,
        backgroundColor: customBackground?.call(Theme.of(context)),
      ),
    );
  }
}

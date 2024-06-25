part of 'package:stage/stage.dart';

class StageSplashScreen extends StatelessWidget {
  const StageSplashScreen({
    required this.background,
    required this.icon,
  });

  final Color background;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: background,
        child: IconTheme.merge(
          data: const IconThemeData(
            size: 120,
          ),
          child: icon,
        ),
      ),
    );
  }
}

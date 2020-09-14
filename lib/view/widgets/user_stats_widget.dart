import 'package:flutter/material.dart';

class UserStatsWidget extends StatelessWidget {
  const UserStatsWidget(
      {Key key,
      @required this.title,
      @required this.score,
      this.borderOption,
      this.borderRadius = const BorderRadius.all(Radius.circular(0.0)),
      @required this.gradientColors})
      : super(key: key);

  final String title;
  final BoxBorder borderOption;
  final String score;
  final BorderRadiusGeometry borderRadius;
  final List<Color> gradientColors;
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: 80, minWidth: 120),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: borderOption,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              score,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ));
  }
}

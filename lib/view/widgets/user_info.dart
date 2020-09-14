import 'package:flutter/material.dart';
import 'package:game_ui/app_localization/app_localization.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key key,
    @required this.username,
    @required this.eloRating,
  }) : super(key: key);

  final String username;
  final double eloRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: Colors.blueAccent,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '$eloRating',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(AppLocalizations.of(context)
                      .translate('elo_rating_text')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

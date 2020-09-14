import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_ui/app_localization/app_localization.dart';
import 'package:game_ui/blocs/language/bloc.dart';
import 'package:game_ui/common/utility.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/no_game_no_life.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Colors.black.withOpacity(.1),
                  Colors.black.withOpacity(.4),
                  Colors.black.withOpacity(.5),
                  Colors.black.withOpacity(.4),
                  Colors.black.withOpacity(.7),
                ])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate('select_language_text'),
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(height: 50),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<LanguageBloc>(context)
                        .add(LanguageSelected(Language.EN));
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context).translate('english_language'),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: FlatButton(
                  onPressed: () {
                    BlocProvider.of<LanguageBloc>(context)
                        .add(LanguageSelected(Language.JA));
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context).translate('japanese_language'),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

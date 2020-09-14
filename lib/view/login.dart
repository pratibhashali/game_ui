import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_ui/app_localization/app_localization.dart';
import 'package:game_ui/blocs/language/bloc.dart';
import 'package:game_ui/common/utility.dart';
import 'package:game_ui/helper/shared_preference_manager.dart';
import 'package:game_ui/view/home_page.dart';
import 'package:game_ui/view/language_selector_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    //test feild state
    String email = "";
    String password = "";
    //for showing loading
    login() async {
      if (_formKey.currentState.validate()) {
        if (email == "admin" && password == "password") {
          final sharedPrefManager = await SharedPreferencesManager.instance;
          sharedPrefManager.setLoginStatus('LoggedIn');

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (r) => false,
          );
        }
        // If the form is valid, display a Snackbar.

      }
    }

    // AppLocalizations.of(context).translate('title'),

    // this below line is used to make notification bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
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
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 60, top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.translate,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectLanguage()),
                          );
                        }),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('welcome'),
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('gamer_text'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            decoration: getFormInputDecoration(
                                AppLocalizations.of(context)
                                    .translate('username_hint_text')),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                            initialValue: email ?? '',
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value.length <= 3 || value.length >= 10) {
                                return AppLocalizations.of(context)
                                    .translate('username_validation_message');
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            decoration: getFormInputDecoration(
                                AppLocalizations.of(context)
                                    .translate('password_hint_text')),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                            initialValue: password ?? '',
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value.length <= 3 || value.length >= 10) {
                                return AppLocalizations.of(context)
                                    .translate('password_validation_message');
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: FlatButton(
                        onPressed: login,
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context).translate('login_text'),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration getFormInputDecoration(String hintText) {
    return InputDecoration(
      errorStyle: TextStyle(fontSize: 10, color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w300, letterSpacing: 1),
    );
  }
}

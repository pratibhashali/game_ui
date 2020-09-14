import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_ui/app_localization/app_localization.dart';
import 'package:game_ui/blocs/homepage/bloc.dart';
import 'package:game_ui/blocs/language/bloc.dart';
import 'package:game_ui/helper/shared_preference_manager.dart';
import 'package:game_ui/view/home_page.dart';
import 'package:game_ui/view/login.dart';

import 'blocs/bloc_observer.dart';
import 'package:http/http.dart' as http;

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefManager = await SharedPreferencesManager.instance;

  String loggedInStatus = sharedPrefManager.getLoginStatus;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HomeBloc>(
        create: (context) =>
            HomeBloc(httpClient: http.Client())..add(HomeFetched()),
      ),
      BlocProvider(
        create: (_) => LanguageBloc()..add(LanguageLoadStarted()),
      ),
    ],
    child: MyApp(
      loggedInStatus: loggedInStatus,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String loggedInStatus;
  MyApp({this.loggedInStatus});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return MaterialApp(
          locale: languageState.locale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ja', 'JA'),
          ],
          title: 'Game UI challenge',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: loggedInStatus == null || loggedInStatus != "LoggedIn"
              ? Scaffold(body: Login())
              : HomePage(),
        );
      },
    );
  }
}

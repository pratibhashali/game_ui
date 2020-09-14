import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_ui/blocs/language/language_event.dart';
import 'package:game_ui/blocs/language/language_state.dart';
import 'package:game_ui/common/utility.dart';
import 'package:game_ui/helper/shared_preference_manager.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(Locale('en', 'US')));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageLoadStarted) {
      yield* _mapLanguageLoadStartedToState();
    } else if (event is LanguageSelected) {
      yield* _mapLanguageSelectedToState(event.languageCode);
    }
  }

  Stream<LanguageState> _mapLanguageLoadStartedToState() async* {
    final sharedPrefManager = await SharedPreferencesManager.instance;

    final defaultLanguageCode = sharedPrefManager.languageCode;
    Locale locale;

    if (defaultLanguageCode == null) {
      locale = Locale('en', 'US');
      await sharedPrefManager.setLanguage(locale.languageCode);
    } else {
      locale = Locale(defaultLanguageCode);
    }

    yield LanguageState(locale);
  }

  Stream<LanguageState> _mapLanguageSelectedToState(
      Language selectedLanguage) async* {
    final sharedPrefManager = await SharedPreferencesManager.instance;
    final defaultLanguageCode = sharedPrefManager.languageCode;

    if (selectedLanguage == Language.JA &&
        defaultLanguageCode != LanguageKeys.ja) {
      yield* _loadLanguage(sharedPrefManager, 'ja', 'JA');
    } else if (selectedLanguage == Language.EN &&
        defaultLanguageCode != LanguageKeys.en) {
      yield* _loadLanguage(sharedPrefManager, 'en', 'US');
    }
  }

  /// This method is added to reduce code repetition.
  Stream<LanguageState> _loadLanguage(
      SharedPreferencesManager sharedPreferencesManager,
      String languageCode,
      String countryCode) async* {
    final locale = Locale(languageCode, countryCode);
    await sharedPreferencesManager.setLanguage(locale.languageCode);
    yield LanguageState(locale);
  }
}

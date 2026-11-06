// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Morse App';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get translate => 'Translate';

  @override
  String get learn => 'Learn';

  @override
  String get account => 'Account';

  @override
  String get feedback => 'Feedback';

  @override
  String version(String version) {
    return 'v$version';
  }

  @override
  String get youreNotLoggedIn => 'You\'re not logged in!';

  @override
  String userLabel(String username) {
    return 'User: $username';
  }

  @override
  String get translateInfo => 'Do you want to translate from MORSE or TEXT?';

  @override
  String get textToMorse => 'Text to Morse';

  @override
  String get morseToText => 'Morse to Text';

  @override
  String get insertText => 'Insert text…';

  @override
  String get writeToTranslate => 'Write to translate…';

  @override
  String get useButtonsBelow => 'Use the buttons below to write…';

  @override
  String get enter => 'ENTER';

  @override
  String get delete => 'CANC';

  @override
  String get selectLearnMethod => 'Select a learn method…';

  @override
  String get choose => 'CHOOSE';

  @override
  String get infiniChoose => '∞ CHOOSE';

  @override
  String get type => 'TYPE';

  @override
  String get words => 'WORDS';

  @override
  String get writeTheAnswer => 'Write the answer…';

  @override
  String get correct => 'Correct!';

  @override
  String get wrong => 'Wrong!';

  @override
  String score(int score) {
    return 'Score: $score';
  }

  @override
  String highScore(int score) {
    return 'HighScore: $score';
  }

  @override
  String newHighScore(int score) {
    return 'New HighScore: $score';
  }

  @override
  String get selectPromptType => 'Select the prompt type…';

  @override
  String get both => 'BOTH';

  @override
  String get onlyMorse => 'Only MORSE';

  @override
  String get onlyText => 'Only TEXT';

  @override
  String get back => 'Back';

  @override
  String get login => 'Login';

  @override
  String get signIn => 'Sign In';

  @override
  String get logOut => 'Log Out';

  @override
  String get username => 'Username';

  @override
  String get insertUsername => 'Insert Username…';

  @override
  String get save => 'Save';

  @override
  String get wait => 'Wait...';

  @override
  String get noHashChar => 'You cannot use the \'#\' char!';

  @override
  String usernameSaved(String username) {
    return 'Welcome, $username';
  }

  @override
  String get yourScores => 'Your scores';

  @override
  String get scoreChoose => 'Infinite Choose';

  @override
  String get scoreHighChoose => 'Choose HighScore';

  @override
  String get scoreType => 'Type';
}

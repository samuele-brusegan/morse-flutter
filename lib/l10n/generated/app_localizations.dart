import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Morse App'**
  String get appTitle;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @learn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learn;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'v{version}'**
  String version(String version);

  /// No description provided for @youreNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You\'re not logged in!'**
  String get youreNotLoggedIn;

  /// No description provided for @userLabel.
  ///
  /// In en, this message translates to:
  /// **'User: {username}'**
  String userLabel(String username);

  /// No description provided for @translateInfo.
  ///
  /// In en, this message translates to:
  /// **'Do you want to translate from MORSE or TEXT?'**
  String get translateInfo;

  /// No description provided for @textToMorse.
  ///
  /// In en, this message translates to:
  /// **'Text to Morse'**
  String get textToMorse;

  /// No description provided for @morseToText.
  ///
  /// In en, this message translates to:
  /// **'Morse to Text'**
  String get morseToText;

  /// No description provided for @insertText.
  ///
  /// In en, this message translates to:
  /// **'Insert text…'**
  String get insertText;

  /// No description provided for @writeToTranslate.
  ///
  /// In en, this message translates to:
  /// **'Write to translate…'**
  String get writeToTranslate;

  /// No description provided for @useButtonsBelow.
  ///
  /// In en, this message translates to:
  /// **'Use the buttons below to write…'**
  String get useButtonsBelow;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'ENTER'**
  String get enter;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'CANC'**
  String get delete;

  /// No description provided for @selectLearnMethod.
  ///
  /// In en, this message translates to:
  /// **'Select a learn method…'**
  String get selectLearnMethod;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE'**
  String get choose;

  /// No description provided for @infiniChoose.
  ///
  /// In en, this message translates to:
  /// **'∞ CHOOSE'**
  String get infiniChoose;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get type;

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'WORDS'**
  String get words;

  /// No description provided for @writeTheAnswer.
  ///
  /// In en, this message translates to:
  /// **'Write the answer…'**
  String get writeTheAnswer;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @wrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong!'**
  String get wrong;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String score(int score);

  /// No description provided for @highScore.
  ///
  /// In en, this message translates to:
  /// **'HighScore: {score}'**
  String highScore(int score);

  /// No description provided for @newHighScore.
  ///
  /// In en, this message translates to:
  /// **'New HighScore: {score}'**
  String newHighScore(int score);

  /// No description provided for @selectPromptType.
  ///
  /// In en, this message translates to:
  /// **'Select the prompt type…'**
  String get selectPromptType;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'BOTH'**
  String get both;

  /// No description provided for @onlyMorse.
  ///
  /// In en, this message translates to:
  /// **'Only MORSE'**
  String get onlyMorse;

  /// No description provided for @onlyText.
  ///
  /// In en, this message translates to:
  /// **'Only TEXT'**
  String get onlyText;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @insertUsername.
  ///
  /// In en, this message translates to:
  /// **'Insert Username…'**
  String get insertUsername;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'Wait...'**
  String get wait;

  /// No description provided for @noHashChar.
  ///
  /// In en, this message translates to:
  /// **'You cannot use the \'#\' char!'**
  String get noHashChar;

  /// No description provided for @usernameSaved.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {username}'**
  String usernameSaved(String username);

  /// No description provided for @yourScores.
  ///
  /// In en, this message translates to:
  /// **'Your scores'**
  String get yourScores;

  /// No description provided for @scoreChoose.
  ///
  /// In en, this message translates to:
  /// **'Infinite Choose'**
  String get scoreChoose;

  /// No description provided for @scoreHighChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose HighScore'**
  String get scoreHighChoose;

  /// No description provided for @scoreType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get scoreType;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

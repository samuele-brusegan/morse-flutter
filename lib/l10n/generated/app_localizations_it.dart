// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Morse App';

  @override
  String get welcomeTo => 'Benvenuto in';

  @override
  String get translate => 'Traduci';

  @override
  String get learn => 'Impara';

  @override
  String get account => 'Account';

  @override
  String get feedback => 'Feedback';

  @override
  String version(String version) {
    return 'v$version';
  }

  @override
  String get youreNotLoggedIn => 'Non hai fatto il login!';

  @override
  String userLabel(String username) {
    return 'Utente: $username';
  }

  @override
  String get translateInfo => 'Vuoi tradurre dal Morse o dal Testo?';

  @override
  String get textToMorse => 'Testo a Morse';

  @override
  String get morseToText => 'Morse a Testo';

  @override
  String get insertText => 'Inserisci testo…';

  @override
  String get writeToTranslate => 'Scrivi per tradurre…';

  @override
  String get useButtonsBelow => 'Usa i bottoni sotto per scrivere…';

  @override
  String get enter => 'INVIO';

  @override
  String get delete => 'CANC';

  @override
  String get selectLearnMethod =>
      'Seleziona il tuo metodo preferito per imparare…';

  @override
  String get choose => 'SCEGLI';

  @override
  String get infiniChoose => '∞ SCEGLI';

  @override
  String get type => 'SCRIVI';

  @override
  String get words => 'PAROLE';

  @override
  String get writeTheAnswer => 'Scrivi la risposta…';

  @override
  String get correct => 'Giusto!';

  @override
  String get wrong => 'Sbagliato!';

  @override
  String score(int score) {
    return 'Punteggio: $score';
  }

  @override
  String highScore(int score) {
    return 'Record: $score';
  }

  @override
  String newHighScore(int score) {
    return 'Nuovo Record: $score';
  }

  @override
  String get selectPromptType => 'Seleziona la tipologia di prompt';

  @override
  String get both => 'ENTRAMBI';

  @override
  String get onlyMorse => 'Solo MORSE';

  @override
  String get onlyText => 'Solo TESTO';

  @override
  String get back => 'Indietro';

  @override
  String get login => 'Login';

  @override
  String get signIn => 'Registrati';

  @override
  String get logOut => 'Esci';

  @override
  String get username => 'Nome utente';

  @override
  String get insertUsername => 'Inserisci il nome utente…';

  @override
  String get save => 'Salva';

  @override
  String get wait => 'Attendi...';

  @override
  String get noHashChar => 'Non puoi usare il carattere \'#\'!';

  @override
  String usernameSaved(String username) {
    return 'Benvenuto, $username';
  }

  @override
  String get yourScores => 'I tuoi punteggi';

  @override
  String get scoreChoose => 'Choose infinito';

  @override
  String get scoreHighChoose => 'Record Choose';

  @override
  String get scoreType => 'Scrivi';
}

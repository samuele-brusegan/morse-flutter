import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Score modes, mirroring the original app.
enum ScoreMode { choose, highChoose, pair, type }

const _kSession = 'session_id';
const _kScoreChoose = 'score_choose';
const _kScoreHighChoose = 'score_high_choose';
const _kScorePair = 'score_pair';
const _kScoreType = 'score_type';

/// Holds the local session (username) and locally persisted scores.
class AppState extends ChangeNotifier {
  SharedPreferences? _prefs;

  String? username;
  final Map<ScoreMode, int> scores = {
    ScoreMode.choose: 0,
    ScoreMode.highChoose: 0,
    ScoreMode.pair: 0,
    ScoreMode.type: 0,
  };

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    final session = _prefs!.getString(_kSession);
    username = (session == null || session.isEmpty || session == '_void_')
        ? null
        : session;
    scores[ScoreMode.choose] = _prefs!.getInt(_kScoreChoose) ?? 0;
    scores[ScoreMode.highChoose] = _prefs!.getInt(_kScoreHighChoose) ?? 0;
    scores[ScoreMode.pair] = _prefs!.getInt(_kScorePair) ?? 0;
    scores[ScoreMode.type] = _prefs!.getInt(_kScoreType) ?? 0;
    notifyListeners();
  }

  bool get isLoggedIn => username != null;

  Future<void> setUsername(String name) async {
    username = name;
    await _prefs?.setString(_kSession, name);
    notifyListeners();
  }

  Future<void> logout() async {
    username = null;
    await _prefs?.setString(_kSession, '_void_');
    notifyListeners();
  }

  Future<void> setScore(ScoreMode mode, int value) async {
    scores[mode] = value;
    final key = switch (mode) {
      ScoreMode.choose => _kScoreChoose,
      ScoreMode.highChoose => _kScoreHighChoose,
      ScoreMode.pair => _kScorePair,
      ScoreMode.type => _kScoreType,
    };
    await _prefs?.setInt(key, value);
    notifyListeners();
  }
}

/// Global app state instance, loaded before [runApp].
final appState = AppState();

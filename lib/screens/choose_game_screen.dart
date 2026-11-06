import 'dart:math';

import 'package:flutter/material.dart';

import '../app_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../morse_codec.dart';
import '../widgets/common.dart';

enum _PromptKind { both, onlyMorse, onlyText }

/// "Learn, Choose" game: a letter or morse code prompt with 4 answers.
///
/// [infinite] = false -> standard mode: +100 per correct answer, score resets
/// to 0 on a mistake and the run competes against the saved high score.
/// [infinite] = true -> cumulative mode: +100 / -50, persisted score.
class ChooseGameScreen extends StatefulWidget {
  const ChooseGameScreen({super.key, required this.infinite});

  final bool infinite;

  @override
  State<ChooseGameScreen> createState() => _ChooseGameScreenState();
}

class _ChooseGameScreenState extends State<ChooseGameScreen>
    with TimedBanner<ChooseGameScreen> {
  static const _len = 26;
  final _rng = Random();

  _PromptKind _kind = _PromptKind.both;
  int _score = 0;
  int _highScore = 0;

  late bool _promptIsMorse;
  late int _promptIndex;
  late List<String> _answers;
  late int _correctPos;

  @override
  void initState() {
    super.initState();
    if (widget.infinite) {
      _score = appState.scores[ScoreMode.choose]!;
    } else {
      _highScore = appState.scores[ScoreMode.highChoose]!;
    }
    _nextRound();
  }

  void _nextRound() {
    _promptIsMorse = switch (_kind) {
      _PromptKind.onlyMorse => true,
      _PromptKind.onlyText => false,
      _PromptKind.both => _rng.nextBool(),
    };
    _promptIndex = _rng.nextInt(_len);

    final pool = _promptIsMorse ? kMorseLetters : kMorseCodes;
    final wrong = <String>{};
    while (wrong.length < 3) {
      final i = _rng.nextInt(_len);
      if (i != _promptIndex) wrong.add(pool[i]);
    }
    _answers = [...wrong, pool[_promptIndex]]..shuffle(_rng);
    _correctPos = _answers.indexOf(pool[_promptIndex]);
  }

  String get _prompt =>
      _promptIsMorse ? kMorseCodes[_promptIndex] : kMorseLetters[_promptIndex];

  String get _correctAnswer =>
      _promptIsMorse ? kMorseLetters[_promptIndex] : kMorseCodes[_promptIndex];

  void _answer(int pos) {
    final l10n = AppLocalizations.of(context);
    if (pos == _correctPos) {
      _score += 100;
      showBanner(
        BannerData(l10n.correct, isCorrect: true),
        const Duration(seconds: 1),
      );
      if (widget.infinite) _persist();
    } else {
      if (widget.infinite) {
        _score -= 50;
        _persist();
        showBanner(
          BannerData('  $_prompt   $_correctAnswer', isCorrect: false),
          const Duration(milliseconds: 2500),
        );
      } else {
        if (_score > _highScore) {
          _highScore = _score;
          appState.setScore(ScoreMode.highChoose, _highScore);
        }
        _score = 0;
        showBanner(
          BannerData('  $_prompt   $_correctAnswer', isCorrect: false),
          const Duration(seconds: 10),
        );
      }
    }
    setState(_nextRound);
  }

  void _persist() => appState.setScore(ScoreMode.choose, _score);

  @override
  void dispose() {
    if (widget.infinite && _score != 0) _persist();
    if (!widget.infinite && _score > _highScore) {
      appState.setScore(ScoreMode.highChoose, _score);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isNewHigh =
        !widget.infinite && _score >= _highScore && _score != 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const CornerBackButton(),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        l10n.learn,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: scheme.primary,
                        ),
                      ),
                      Text(
                        widget.infinite ? l10n.infiniChoose : l10n.choose,
                        style:
                            TextStyle(fontSize: 20, color: scheme.secondary),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 8),
              // Scoreboard
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isNewHigh)
                    Text(l10n.score(_score),
                        style: const TextStyle(fontSize: 18)),
                  if (!widget.infinite) ...[
                    if (!isNewHigh) const SizedBox(width: 24),
                    Text(
                      isNewHigh
                          ? l10n.newHighScore(_score)
                          : l10n.highScore(_highScore),
                      style: TextStyle(
                        fontSize: 18,
                        color: isNewHigh
                            ? const Color(0xFF00C853)
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              SegmentedButton<_PromptKind>(
                segments: [
                  ButtonSegment(
                    value: _PromptKind.both,
                    label: Text(l10n.both),
                  ),
                  ButtonSegment(
                    value: _PromptKind.onlyMorse,
                    label: Text(l10n.onlyMorse),
                  ),
                  ButtonSegment(
                    value: _PromptKind.onlyText,
                    label: Text(l10n.onlyText),
                  ),
                ],
                selected: {_kind},
                onSelectionChanged: (s) =>
                    setState(() => _kind = s.first),
              ),
              const SizedBox(height: 16),
              FeedbackBanner(data: banner),
              // Prompt
              Expanded(
                child: Center(
                  child: Text(
                    _prompt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Answers 2x2
              for (var row = 0; row < 2; row++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      for (var col = 0; col < 2; col++) ...[
                        if (col == 1) const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 76,
                            child: FilledButton.tonal(
                              onPressed: () => _answer(row * 2 + col),
                              style: FilledButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 28),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(_answers[row * 2 + col]),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import '../app_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../morse_codec.dart';
import '../widgets/common.dart';

/// "Learn, Type": a letter or morse prompt, the user types the counterpart.
/// +100 on a correct answer, -50 on a wrong one. Score persisted as "type".
class LearnTypeScreen extends StatefulWidget {
  const LearnTypeScreen({super.key});

  @override
  State<LearnTypeScreen> createState() => _LearnTypeScreenState();
}

class _LearnTypeScreenState extends State<LearnTypeScreen>
    with TimedBanner<LearnTypeScreen> {
  static const _len = 26;
  final _rng = Random();
  final _controller = TextEditingController();

  int _score = 0;
  late bool _promptIsMorse;
  late int _index;

  @override
  void initState() {
    super.initState();
    _score = appState.scores[ScoreMode.type]!;
    _nextRound();
  }

  void _nextRound() {
    _promptIsMorse = _rng.nextBool();
    _index = _rng.nextInt(_len);
    _controller.clear();
  }

  String get _prompt =>
      _promptIsMorse ? kMorseCodes[_index] : kMorseLetters[_index];

  String get _answer =>
      _promptIsMorse ? kMorseLetters[_index] : kMorseCodes[_index];

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final input = _controller.text.trim();
    if (input.isEmpty) return;
    final ok = _promptIsMorse
        ? input.toUpperCase() == _answer
        : input == _answer;
    if (ok) {
      _score += 100;
      showBanner(
        BannerData(l10n.correct, isCorrect: true),
        const Duration(seconds: 1),
      );
    } else {
      _score -= 50;
      showBanner(
        BannerData('  $_prompt   $_answer', isCorrect: false),
        const Duration(milliseconds: 2500),
      );
    }
    appState.setScore(ScoreMode.type, _score);
    setState(_nextRound);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        l10n.type,
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
              Center(
                child: Text(
                  l10n.score(_score),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              FeedbackBanner(data: banner),
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
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: l10n.writeTheAnswer,
                  border: const OutlineInputBorder(),
                ),
                autocorrect: false,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 16),
              Center(
                child: FilledButton(
                  onPressed: _submit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child:
                        Text(l10n.enter, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

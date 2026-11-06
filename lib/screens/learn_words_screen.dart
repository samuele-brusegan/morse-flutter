import 'dart:math';

import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../morse_codec.dart';
import '../widgets/common.dart';

const _kScoutWords = [
  'Avventura', 'Esplorazione', 'Bussola', 'Tenda', 'Scoutismo',
  'Caccia', 'Uguaglianza', 'Natura', 'Bivacco', 'Sentiero',
  'Branco', 'Campo', 'Fuoco', 'Promessa', 'Legge', 'Squadriglia',
  'Uniforme', 'Nodo', 'Orientamento', 'Simbolo', 'Servizio',
  'Condivisione', 'Rispettare', 'Coraggio', 'Nord', 'Missione',
  'Grande Gioco', 'Gara di cucina', 'Il capo supremo Tony',
  'Brevetto', 'Specialita',
];

/// "Learn, Words": decode a morse-encoded word.
class LearnWordsScreen extends StatefulWidget {
  const LearnWordsScreen({super.key});

  @override
  State<LearnWordsScreen> createState() => _LearnWordsScreenState();
}

class _LearnWordsScreenState extends State<LearnWordsScreen>
    with TimedBanner<LearnWordsScreen> {
  final _rng = Random();
  final _controller = TextEditingController();
  int _lastIndex = -2;
  late String _word;
  late String _morse;

  @override
  void initState() {
    super.initState();
    _nextWord();
  }

  void _nextWord() {
    var i = _rng.nextInt(_kScoutWords.length);
    while (i == _lastIndex) {
      i = _rng.nextInt(_kScoutWords.length);
    }
    _lastIndex = i;
    _word = _kScoutWords[i];
    _morse = morseEncode(_word);
    _controller.clear();
  }

  String _normalize(String s) => s.replaceAll(' ', '').toLowerCase();

  void _submit() {
    final l10n = AppLocalizations.of(context);
    if (_normalize(_controller.text) == _normalize(_word)) {
      showBanner(
        BannerData(l10n.correct, isCorrect: true),
        const Duration(seconds: 2),
      );
    } else {
      showBanner(
        BannerData(_word, isCorrect: false),
        const Duration(seconds: 2),
      );
    }
    setState(_nextWord);
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
                        l10n.words,
                        style:
                            TextStyle(fontSize: 20, color: scheme.secondary),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              FeedbackBanner(data: banner),
              Expanded(
                child: Center(
                  child: Text(
                    _morse,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
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

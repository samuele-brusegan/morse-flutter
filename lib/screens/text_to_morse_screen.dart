import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/generated/app_localizations.dart';
import '../morse_codec.dart';
import '../widgets/common.dart';

class TextToMorseScreen extends StatefulWidget {
  const TextToMorseScreen({super.key});

  @override
  State<TextToMorseScreen> createState() => _TextToMorseScreenState();
}

class _TextToMorseScreenState extends State<TextToMorseScreen> {
  final _controller = TextEditingController();
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () => setState(() => _output = morseEncode(_controller.text)),
    );
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
                  Expanded(
                    child: Text(
                      l10n.textToMorse,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: l10n.insertText,
                  border: const OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onLongPress: _output.isEmpty
                        ? null
                        : () => Clipboard.setData(ClipboardData(text: _output)),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _output.isEmpty ? l10n.writeToTranslate : _output,
                        style: TextStyle(
                          fontSize: 24,
                          color: _output.isEmpty
                              ? scheme.onSurfaceVariant
                              : scheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

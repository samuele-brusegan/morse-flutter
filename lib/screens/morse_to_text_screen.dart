import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../morse_codec.dart';
import '../widgets/common.dart';

class MorseToTextScreen extends StatefulWidget {
  const MorseToTextScreen({super.key});

  @override
  State<MorseToTextScreen> createState() => _MorseToTextScreenState();
}

class _MorseToTextScreenState extends State<MorseToTextScreen> {
  String _input = '';
  String _decoded = '';
  bool _showDecoded = false;

  void _append(String ch) => setState(() {
        _input += ch;
        _showDecoded = false;
      });

  void _delete() {
    if (_input.isEmpty) return;
    setState(() {
      _input = _input.substring(0, _input.length - 1);
      _showDecoded = false;
    });
  }

  void _enter() => setState(() {
        _decoded = morseDecode(_input);
        _showDecoded = true;
      });

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
                      l10n.morseToText,
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
              // Morse preview
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 90),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _input.isEmpty ? l10n.useButtonsBelow : _input,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _input.isEmpty
                        ? scheme.onSurfaceVariant
                        : scheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Decoded output
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 60),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.outlineVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _showDecoded ? _decoded : '',
                  style: TextStyle(fontSize: 28, color: scheme.primary),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: FilledButton(
                  onPressed: _input.isEmpty ? null : _enter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Text(l10n.enter, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const Spacer(),
              // Morse keypad
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _KeyButton(label: '-', onPressed: () => _append('-')),
                  _KeyButton(label: '.', onPressed: () => _append('.')),
                  _KeyButton(label: '/', onPressed: () => _append('/')),
                  _KeyButton(
                    label: l10n.delete,
                    small: true,
                    onPressed: _delete,
                  ),
                ],
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  const _KeyButton({
    required this.label,
    required this.onPressed,
    this.small = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(label, style: TextStyle(fontSize: small ? 16 : 34)),
      ),
    );
  }
}

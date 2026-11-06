import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../widgets/common.dart';

class TranslateHomeScreen extends StatelessWidget {
  const TranslateHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(top: 8, left: 8, child: CornerBackButton()),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.translate,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      l10n.translateInfo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 48),
                  MenuButton(
                    label: l10n.textToMorse,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/translate/t2m'),
                  ),
                  const SizedBox(height: 20),
                  MenuButton(
                    label: l10n.morseToText,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/translate/m2t'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

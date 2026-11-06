import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../widgets/common.dart';

class LearnHomeScreen extends StatelessWidget {
  const LearnHomeScreen({super.key});

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
                    l10n.learn,
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
                      l10n.selectLearnMethod,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 40),
                  MenuButton(
                    label: l10n.choose,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/learn/choose'),
                  ),
                  const SizedBox(height: 16),
                  MenuButton(
                    label: l10n.words,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/learn/words'),
                  ),
                  const SizedBox(height: 16),
                  MenuButton(
                    label: l10n.type,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/learn/type'),
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

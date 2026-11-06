import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../widgets/common.dart';

class LearnChooseHomeScreen extends StatelessWidget {
  const LearnChooseHomeScreen({super.key});

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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                  Text(
                    l10n.choose,
                    style: TextStyle(fontSize: 22, color: scheme.secondary),
                  ),
                  const SizedBox(height: 48),
                  MenuButton(
                    label: l10n.choose,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/learn/choose/standard'),
                  ),
                  const SizedBox(height: 20),
                  MenuButton(
                    label: l10n.infiniChoose,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/learn/choose/infini'),
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

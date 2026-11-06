import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then(
      (info) => setState(() => _version = info.version),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Current user / account
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: ListenableBuilder(
                listenable: appState,
                builder: (context, _) => Text(
                  appState.isLoggedIn
                      ? l10n.userLabel(appState.username!)
                      : l10n.youreNotLoggedIn,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 4,
              child: IconButton(
                icon: Icon(Icons.face, size: 44, color: scheme.primary),
                tooltip: l10n.account,
                onPressed: () => Navigator.pushNamed(context, '/account'),
              ),
            ),

            // Title + main actions
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.welcomeTo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                  Text(
                    l10n.appTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: 48),
                  MenuButton(
                    label: l10n.translate,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/translate'),
                  ),
                  const SizedBox(height: 20),
                  MenuButton(
                    label: l10n.learn,
                    onPressed: () => Navigator.pushNamed(context, '/learn'),
                  ),
                ],
              ),
            ),

            // Feedback (bottom-left) + version (bottom-right)
            Positioned(
              bottom: 4,
              left: 4,
              child: IconButton(
                icon: Icon(Icons.feedback, size: 36, color: scheme.secondary),
                tooltip: l10n.feedback,
                onPressed: () => launchUrl(
                  Uri.parse(
                    'https://github.com/samuele-brusegan/morse-flutter/issues/new',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Text(
                _version.isEmpty ? '' : l10n.version(_version),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

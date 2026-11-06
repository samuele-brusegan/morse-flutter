import 'package:flutter/material.dart';

import '../app_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/common.dart';

/// Local account: pick a display name and see locally saved scores.
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    final name = _controller.text.trim();
    if (name.contains('#')) {
      setState(() => _error = l10n.noHashChar);
      return;
    }
    if (name.isEmpty) return;
    appState.setUsername(name);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListenableBuilder(
            listenable: appState,
            builder: (context, _) {
              final loggedIn = appState.isLoggedIn;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CornerBackButton(),
                      Expanded(
                        child: Text(
                          l10n.account,
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
                  const SizedBox(height: 40),
                  if (loggedIn) ...[
                    Text(
                      l10n.userLabel(appState.username!),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l10n.yourScores,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: scheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ScoreRow(
                      label: l10n.scoreChoose,
                      value: appState.scores[ScoreMode.choose]!,
                    ),
                    _ScoreRow(
                      label: l10n.scoreHighChoose,
                      value: appState.scores[ScoreMode.highChoose]!,
                    ),
                    _ScoreRow(
                      label: l10n.scoreType,
                      value: appState.scores[ScoreMode.type]!,
                    ),
                    const Spacer(),
                    Center(
                      child: OutlinedButton(
                        onPressed: appState.logout,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          child: Text(
                            l10n.logOut,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ] else ...[
                    Text(
                      l10n.youreNotLoggedIn,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: l10n.username,
                        hintText: l10n.insertUsername,
                        border: const OutlineInputBorder(),
                        errorText: _error,
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _save(),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: FilledButton(
                        onPressed: _save,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          child: Text(
                            l10n.save,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(
            '$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

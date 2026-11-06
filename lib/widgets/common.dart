import 'package:flutter/material.dart';
import 'dart:async';

/// Large, bold menu button used across the app's navigation screens.
class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 76,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        child: icon == null
            ? Text(label)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Flexible(child: Text(label)),
                ],
              ),
      ),
    );
  }
}

/// Small circular back button shown in the top-left corner,
/// mirroring the original app's back buttons.
class CornerBackButton extends StatelessWidget {
  const CornerBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      icon: const Icon(Icons.arrow_back),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => Navigator.of(context).maybePop(),
    );
  }
}

/// Transient feedback banner (green = correct, red = wrong),
/// like the original app's isCorrect* views.
class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key, required this.data});

  final BannerData? data;

  @override
  Widget build(BuildContext context) {
    final d = data;
    if (d == null) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: d.isCorrect ? const Color(0xFF2E7D32) : scheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        d.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: d.isCorrect ? Colors.white : scheme.onErrorContainer,
        ),
      ),
    );
  }
}

class BannerData {
  BannerData(this.text, {required this.isCorrect});
  final String text;
  final bool isCorrect;
}

/// Helper to show a [FeedbackBanner] value for [duration] and then clear it.
mixin TimedBanner<T extends StatefulWidget> on State<T> {
  BannerData? banner;
  Timer? _bannerTimer;

  void showBanner(BannerData data, Duration duration) {
    _bannerTimer?.cancel();
    setState(() => banner = data);
    _bannerTimer = Timer(duration, () {
      if (mounted) setState(() => banner = null);
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }
}

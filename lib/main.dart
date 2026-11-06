import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_state.dart';
import 'l10n/generated/app_localizations.dart';
import 'screens/account_screen.dart';
import 'screens/choose_game_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_choose_home_screen.dart';
import 'screens/learn_home_screen.dart';
import 'screens/learn_type_screen.dart';
import 'screens/learn_words_screen.dart';
import 'screens/morse_to_text_screen.dart';
import 'screens/text_to_morse_screen.dart';
import 'screens/translate_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appState.load();
  runApp(const MorseApp());
}

class MorseApp extends StatelessWidget {
  const MorseApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF6200EE);
    return MaterialApp(
      title: 'MORSE',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/translate': (_) => const TranslateHomeScreen(),
        '/translate/t2m': (_) => const TextToMorseScreen(),
        '/translate/m2t': (_) => const MorseToTextScreen(),
        '/learn': (_) => const LearnHomeScreen(),
        '/learn/choose': (_) => const LearnChooseHomeScreen(),
        '/learn/choose/standard': (_) =>
            const ChooseGameScreen(infinite: false),
        '/learn/choose/infini': (_) => const ChooseGameScreen(infinite: true),
        '/learn/words': (_) => const LearnWordsScreen(),
        '/learn/type': (_) => const LearnTypeScreen(),
        '/account': (_) => const AccountScreen(),
      },
    );
  }
}

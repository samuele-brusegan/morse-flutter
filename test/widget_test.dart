import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morse/main.dart';
import 'package:morse/morse_codec.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('morse codec', () {
    test('encodes letters separated by /', () {
      expect(morseEncode('AB'), '.-/-.../');
      expect(morseEncode('sos'), '.../---/.../');
    });

    test('encodes spaces as word separators', () {
      expect(morseEncode('A B'), '.-//-.../');
    });

    test('decodes morse to text', () {
      expect(morseDecode('.-/-.../'), 'AB');
      expect(morseDecode('.-//-.../'), 'A B');
      expect(morseDecode('.../---/.../'), 'SOS');
    });

    test('unknown tokens decode to #', () {
      expect(morseDecode('....../'), '#');
    });

    test('ignores non-letters in encode', () {
      expect(morseEncode('A1B'), '.-/-.../');
    });
  });

  testWidgets('home screen shows title and menu', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MorseApp());
    await tester.pumpAndSettle();

    expect(find.text('Morse App'), findsOneWidget);
    expect(find.byType(FilledButton), findsNWidgets(2));
  });
}

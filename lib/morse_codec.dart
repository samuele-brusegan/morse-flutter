/// Morse <-> text codec.
///
/// Letters are separated by '/', words by '//'.
/// Unknown morse tokens decode to '#'.
library;

const List<String> kMorseLetters = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
];

const List<String> kMorseCodes = [
  '.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..',
  '.---', '-.-', '.-..', '--', '-.', '---', '.--.', '--.-', '.-.',
  '...', '-', '..-', '...-', '.--', '-..-', '-.--', '--..',
];

final Map<String, String> _charToMorse = {
  for (var i = 0; i < kMorseLetters.length; i++) kMorseLetters[i]: kMorseCodes[i],
};

final Map<String, String> _morseToChar = {
  for (var i = 0; i < kMorseCodes.length; i++) kMorseCodes[i]: kMorseLetters[i],
};

/// Encodes plain text into morse.
/// "AB C" -> ".-/-...//-.-./"
String morseEncode(String text) {
  final out = StringBuffer();
  for (final ch in text.toUpperCase().split('')) {
    if (ch == ' ') {
      out.write('/');
    } else {
      final code = _charToMorse[ch];
      if (code != null) out.write('$code/');
    }
  }
  return out.toString();
}

/// Decodes morse into plain text.
/// ".-/-...//-.-./" -> "AB C"
String morseDecode(String morse) {
  return morse
      .split('//')
      .map(
        (word) => word
            .split('/')
            .where((token) => token.isNotEmpty)
            .map((token) => _morseToChar[token] ?? '#')
            .join(),
      )
      .join(' ')
      .trim();
}

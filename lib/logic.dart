class Logic {
  String caesar(String text, int key, int encrypt) {
    String result = "";

    for (var i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i), offset = 0, x;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        result += " ";
        continue;
      } else {
        result += String.fromCharCode(ch);
        continue;
      }

      if (encrypt == 1) {
        x = (ch + key - offset) % 26;
      } else {
        x = (ch - key - offset) % 26;
      }

      result += String.fromCharCode(x + offset);
    }
    return result;
  }

  String vigenere(String text, String key, int mode) {
    String result = '';
    int keyIndex = 0;
    for (int i = 0; i < text.length; i++) {
      int textChar = text[i].toUpperCase().codeUnitAt(0);
      if (textChar >= 65 && textChar <= 90) {
        int keyChar = key[keyIndex % key.length].toUpperCase().codeUnitAt(0);
        int shift = keyChar - 65;

        if (mode == 1) {
          result += String.fromCharCode(((textChar - 65 + shift) % 26) + 65);
        } else if (mode == 0) {
          result +=
              String.fromCharCode(((textChar - 65 - shift + 26) % 26) + 65);
        }

        keyIndex++;
      } else {
        result += text[i];
      }
    }
    return result;
  }
}

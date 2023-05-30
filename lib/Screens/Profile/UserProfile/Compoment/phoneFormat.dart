import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  final String separator = '-';
  final List<int> separatorPositions = [3, 6];

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove any non-numeric characters from the new value
    final numericRegex = RegExp(r'[0-9]');
    final newDigits = newValue.text
        .split('')
        .where((char) => numericRegex.hasMatch(char))
        .join('');

    // If the new value is longer than 10 digits, truncate it
    final maxLength = 10;
    final truncatedDigits = newDigits.substring(0, maxLength);

    // Add separators to the truncated digits
    final parts = <String>[];
    for (var i = 0; i < truncatedDigits.length; i += 1) {
      final char = truncatedDigits[i];
      if (separatorPositions.contains(i)) {
        parts.add(separator);
      }
      parts.add(char);
    }

    // Combine the parts into a formatted string
    final formattedValue = parts.join('');

    // Return the new value with the formatted text and selection position
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

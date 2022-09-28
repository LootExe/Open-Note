import 'package:flutter/material.dart';

class TextFieldSheet {
  static Future<String?> show({
    required BuildContext context,
    required String labelText,
    String initialText = '',
  }) async {
    final String? text = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                TextFormField(
                  initialValue: initialText,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: labelText,
                    filled: false,
                    suffixIcon: const Icon(Icons.edit),
                  ),
                  onFieldSubmitted: (value) => Navigator.of(context).pop(value),
                ),
              ],
            ),
          ),
        );
      },
    );

    return text;
  }
}

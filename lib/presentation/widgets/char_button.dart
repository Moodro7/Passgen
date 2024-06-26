import 'package:flutter/material.dart';

class CharButton extends StatelessWidget {
  final String label;
  final String charSet;
  final Set<String> selectedCharSets;
  final VoidCallback onSelectionChanged;

  CharButton({required this.label, required this.charSet, required this.selectedCharSets, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (selectedCharSets.contains(charSet)) {
          selectedCharSets.remove(charSet);
        } else {
          selectedCharSets.add(charSet);
        }
        onSelectionChanged();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (selectedCharSets.contains(charSet)) {
              return Colors.purple[100]!;
            } else {
              return Colors.grey[400]!;
            }
          },
        ),
      ),
      child: Text(label),
    );
  }
}

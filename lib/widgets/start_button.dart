import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function action;

  const StartButton({
    super.key,
    required this.title,
    required this.color,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    double fontSizeText = MediaQuery.of(context).size.height * 0.035;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => action(),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSizeText,
          ),
        ),
      ),
    );
  }
}

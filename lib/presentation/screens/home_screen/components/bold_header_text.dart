import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';

class BoldHeaderText extends StatelessWidget {
  const BoldHeaderText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: AppTheme.lightPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24.0),
    );
  }
}

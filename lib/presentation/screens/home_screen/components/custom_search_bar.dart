import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: const [
          Expanded(
            child: TextField(
              showCursor: false,
              decoration: InputDecoration(
                  focusColor: AppTheme.lightDisabledColor,
                  hintStyle: TextStyle(
                      color: AppTheme.lightDisabledColor,
                      fontWeight: FontWeight.bold),
                  hintText: 'Search Diaries',
                  border: InputBorder.none),
            ),
          ),
          Icon(
            Icons.search,
          ),
        ],
      ),
    );
  }
}

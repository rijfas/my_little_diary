import 'package:flutter/material.dart';

import '../../core/themes/app_theme.dart';
import '../../data/models/entry.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({
    Key? key,
    required this.entry,
    required this.onOpen,
    this.color = Colors.blue,
  }) : super(key: key);
  final Entry entry;
  final Color color;
  final void Function(Entry entry) onOpen;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(5.0)),
            width: 12.0,
            height: 40.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.createdAt.toString(),
                  style: const TextStyle(
                    color: AppTheme.lightDisabledColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  entry.title,
                  style: const TextStyle(
                    color: AppTheme.lightPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => onOpen(entry)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

import 'package:my_little_diary/data/models/diary.dart';

class DiaryIcon extends StatelessWidget {
  const DiaryIcon({
    Key? key,
    required this.diary,
    required this.onTap,
  }) : super(key: key);

  final Diary diary;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: size.width * 0.33,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 4.0)
                      ],
                      color: diary.color[100],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.33 * 0.1,
                    color: diary.color,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              diary.title,
              style: const TextStyle(
                color: AppTheme.lightDisabledColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

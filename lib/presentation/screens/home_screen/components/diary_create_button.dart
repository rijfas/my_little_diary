import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';
import 'rounded_text_field_with_color.dart';

class DiaryCreateButton extends StatelessWidget {
  const DiaryCreateButton({
    Key? key,
    required this.onDiaryCreated,
  }) : super(key: key);
  final void Function(String title, MaterialColor color) onDiaryCreated;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        final _controller = TextEditingController();
        MaterialColor _selectedColor = Colors.blue;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.lightSecondaryColor,
                  title: const Text('Create New Diary'),
                  content: RoundedTextFieldWithColor(
                    controller: _controller,
                    onColorSelected: (color) => _selectedColor = color,
                    selectedColor: _selectedColor,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        onDiaryCreated(_controller.value.text, _selectedColor);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Create'),
                    )
                  ],
                ));
      },
      child: Opacity(
        opacity: 0.33,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
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
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.33 * 0.1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'New Diary',
                    style: TextStyle(
                      color: AppTheme.lightDisabledColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.add,
              color: AppTheme.lightPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}

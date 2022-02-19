import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:my_little_diary/core/themes/app_theme.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late final QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.chevron_left,
              color: AppTheme.lightDisabledColor,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saturday',
                        style: TextStyle(
                            color: AppTheme.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0),
                      ),
                      Text(
                        'November 16',
                        style: TextStyle(
                            color: AppTheme.lightDisabledColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Save'),
                )
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: QuillToolbar.basic(
              toolbarIconAlignment: WrapAlignment.center,
              toolbarSectionSpacing: 1,
              controller: _controller,
              showCodeBlock: false,
              showImageButton: false,
              showRedo: false,
              showUndo: false,
              showVideoButton: false,
              showLink: false,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            padding: const EdgeInsets.all(24.0),
            child: QuillEditor.basic(controller: _controller, readOnly: false),
          ))
        ],
      ),
    );
  }
}

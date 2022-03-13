import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:my_little_diary/data/models/diary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/logic/diary/diary_bloc.dart';
import 'package:my_little_diary/presentation/screens/components/rounded_text_field_with_color.dart';
import 'package:uuid/uuid.dart';

enum Mode { view, edit }

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key, this.diary}) : super(key: key);
  final Diary? diary;

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late final QuillController _controller;
  late final DateTime _date;
  late String _title;
  late Mode _mode;
  @override
  void initState() {
    super.initState();
    _title = (widget.diary == null) ? 'Untitled' : widget.diary!.title;
    _date = (widget.diary == null) ? DateTime.now() : widget.diary!.createdAt;
    _controller = (widget.diary == null)
        ? QuillController(
            document: Document(),
            selection: const TextSelection.collapsed(offset: 0))
        : QuillController(
            document: Document.fromJson(
              jsonDecode(widget.diary!.content),
            ),
            selection: const TextSelection.collapsed(offset: 0));
    _mode = (widget.diary == null) ? Mode.edit : Mode.view;
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
                        _title,
                        style: const TextStyle(
                            // color: AppTheme.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0),
                      ),
                      Text(
                        _date.toString(),
                        style: const TextStyle(
                            // color: AppTheme.lightDisabledColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Color _selectedColor = (widget.diary != null)
                            ? widget.diary!.color
                            : Colors.blue;
                        final TextEditingController textEditingController =
                            TextEditingController(text: widget.diary?.title);
                        if (_mode == Mode.view) {
                          setState(() {
                            _mode = Mode.edit;
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              // backgroundColor: AppTheme.lightSecondaryColor,
                              title: const Text('Save Diary'),
                              content: RoundedTextFieldWithColor(
                                controller: textEditingController,
                                onColorSelected: (color) =>
                                    _selectedColor = color,
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
                                    final diary = (widget.diary == null)
                                        ? Diary(
                                            id: const Uuid().v4(),
                                            title: textEditingController
                                                .value.text,
                                            createdAt: _date,
                                            color: _selectedColor,
                                            content: jsonEncode(
                                              _controller.document
                                                  .toDelta()
                                                  .toJson(),
                                            ),
                                          )
                                        : widget.diary!.copyWith(
                                            color: _selectedColor,
                                            title: textEditingController
                                                .value.text,
                                            content: jsonEncode(
                                              _controller.document
                                                  .toDelta()
                                                  .toJson(),
                                            ),
                                          );
                                    context
                                        .read<DiaryBloc>()
                                        .add(AddDiary(diary: diary));
                                    setState(() {
                                      _mode = Mode.view;
                                      _title = textEditingController.value.text;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: (_mode == Mode.view)
                          ? const Text('Edit')
                          : const Text('Save'),
                    ),
                    if (widget.diary != null)
                      ElevatedButton(
                          onPressed: () {
                            context
                                .read<DiaryBloc>()
                                .add(RemoveDiary(diary: widget.diary!));
                            Navigator.of(context).pop();
                          },
                          child: const Text('Delete'))
                  ],
                )
              ],
            ),
          ),
          if (_mode == Mode.edit) ...[
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
            const SizedBox(height: 16.0)
          ],
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
            child: QuillEditor(
              scrollable: true,
              focusNode: FocusNode(),
              autoFocus: false,
              expands: true,
              padding: const EdgeInsets.all(8.0),
              scrollController: ScrollController(),
              showCursor: _mode == Mode.edit,
              controller: _controller,
              readOnly: _mode == Mode.view,
            ),
          ))
        ],
      ),
    );
  }
}

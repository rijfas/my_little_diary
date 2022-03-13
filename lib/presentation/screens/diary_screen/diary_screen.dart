import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_little_diary/core/theme/app_theme.dart';
import 'package:my_little_diary/core/utils/random_color.dart';
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
  Diary? _diary;
  late final QuillController _controller;
  late final DateTime _date;
  late String _title;
  late Mode _mode;
  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _date = (widget.diary == null) ? DateTime.now() : widget.diary!.createdAt;
    _title = (widget.diary == null) ? 'Create diary' : widget.diary!.title;
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
        foregroundColor: _diary?.color,
        backgroundColor: _diary?.color.withOpacity(0.1),
        leading: IconButton(
          onPressed: () {
            if (_diary != null && _mode == Mode.edit) {
              setState(() {
                _mode = Mode.view;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: Text(
          _title,
          style: TextStyle(color: _diary?.color),
        ),
        actions: [
          if (_diary != null)
            IconButton(
              onPressed: () async {
                final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppTheme.lightSecondaryColor,
                          title: const Text('Delete Diary?'),
                          content: Text(
                              'Are you sure to delete the diary "${_diary!.title}"'),
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
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Confirm'),
                            )
                          ],
                        ));
                if (confirmDelete ?? false) {
                  context.read<DiaryBloc>().add(RemoveDiary(diary: _diary!));
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(FontAwesomeIcons.trash),
            )
        ],
      ),
      body: Container(
        color: _diary?.color.withOpacity(0.1),
        child: Column(
          children: [
            if (_diary != null)
              DatePanel(date: _diary!.createdAt, color: _diary!.color),
            if (_mode == Mode.edit) ...[
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: QuillToolbar.basic(
                  toolbarIconAlignment: WrapAlignment.center,
                  iconTheme: QuillIconTheme(
                    iconSelectedFillColor:
                        widget.diary?.color ?? AppTheme.lightPrimaryColor,
                  ),
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
            ],
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
              child: QuillEditor(
                scrollable: true,
                focusNode: FocusNode(),
                autoFocus: _mode == Mode.edit,
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
      ),
      floatingActionButton: (_mode == Mode.view)
          ? FloatingActionButton(
              backgroundColor: _diary?.color,
              child: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _mode = Mode.edit;
                });
              })
          : FloatingActionButton(
              backgroundColor: _diary?.color,
              child: const Icon(Icons.save),
              onPressed: () {
                Color _selectedColor = (widget.diary != null)
                    ? widget.diary!.color
                    : RandomColor.randomColor();
                final _formKey = GlobalKey<FormState>();
                final TextEditingController textEditingController =
                    TextEditingController(
                        text: widget.diary?.title ??
                            DateFormat.EEEE().format(DateTime.now()));
                showDialog(
                  context: context,
                  builder: (context) => Form(
                    key: _formKey,
                    child: AlertDialog(
                      backgroundColor: AppTheme.lightSecondaryColor,
                      title: const Text('Save Diary'),
                      content: RoundedTextFieldWithColor(
                        controller: textEditingController,
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
                            if (_formKey.currentState!.validate()) {
                              final diary = (widget.diary == null)
                                  ? Diary(
                                      id: const Uuid().v4(),
                                      title: textEditingController.value.text,
                                      createdAt: _date,
                                      color: _selectedColor,
                                      content: jsonEncode(
                                        _controller.document.toDelta().toJson(),
                                      ),
                                    )
                                  : widget.diary!.copyWith(
                                      color: _selectedColor,
                                      title: textEditingController.value.text,
                                      content: jsonEncode(
                                        _controller.document.toDelta().toJson(),
                                      ),
                                    );
                              context
                                  .read<DiaryBloc>()
                                  .add(AddDiary(diary: diary));
                              setState(() {
                                _mode = Mode.view;
                                _title = textEditingController.value.text;
                                _diary = diary;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Save'),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

class DatePanel extends StatelessWidget {
  const DatePanel({Key? key, required this.date, required this.color})
      : super(key: key);

  final DateTime date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              border: Border.all(color: color),
            ),
            child: Text(
              DateFormat('dd').format(date),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 64.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE').format(date),
                style: TextStyle(
                  color: color,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('MMM-yyyy').format(date),
                style: TextStyle(
                  color: color,
                  fontSize: 18.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

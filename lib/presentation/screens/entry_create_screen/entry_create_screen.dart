import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../core/themes/app_theme.dart';
import '../../../data/models/models.dart';
import '../../../logic/entry/entry_cubit.dart';

class EntryCreateScreen extends StatefulWidget {
  const EntryCreateScreen({
    Key? key,
    this.diary,
    this.entry,
  }) : super(key: key);
  final Diary? diary;
  final Entry? entry;
  @override
  State<EntryCreateScreen> createState() => _EntryCreateScreenState();
}

class _EntryCreateScreenState extends State<EntryCreateScreen> {
  late final QuillController _controller;
  late final TextEditingController _textEditingController;
  late final DateTime _date;
  @override
  void initState() {
    const days = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    super.initState();
    _date = widget.entry == null ? DateTime.now() : widget.entry!.createdAt;
    _controller = QuillController(
      document: widget.entry == null
          ? Document()
          : Document.fromJson(jsonDecode(widget.entry!.data)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _textEditingController = TextEditingController(
        text: widget.entry == null
            ? days[DateTime.now().weekday - 1]
            : widget.entry!.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
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
                      EditableText(
                        controller: _textEditingController,
                        backgroundCursorColor: Colors.blue,
                        cursorColor: Colors.blue,
                        focusNode: FocusNode(),
                        style: const TextStyle(
                            color: AppTheme.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0),
                      ),
                      Text(
                        _date.toString(),
                        style: const TextStyle(
                            color: AppTheme.lightDisabledColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final data =
                        jsonEncode(_controller.document.toDelta().toJson());
                    if (widget.entry == null) {
                      context.read<EntryCubit>().addEntry(
                          diary: widget.diary!,
                          title: _textEditingController.value.text,
                          data: data);
                    } else {
                      context.read<EntryCubit>().editEntry(
                            // diary: widget.diary,
                            oldEntry: widget.entry!,
                            title: _textEditingController.value.text,
                            data: data,
                          );
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
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

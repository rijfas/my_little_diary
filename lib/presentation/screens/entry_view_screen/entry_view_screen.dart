import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:my_little_diary/logic/entry/entry_cubit.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themes/app_theme.dart';
import '../../../data/models/models.dart';

class EntryViewScreen extends StatefulWidget {
  const EntryViewScreen({
    Key? key,
    // required this.diary,
    required this.entry,
  }) : super(key: key);
  // final Diary diary;
  final Entry entry;

  @override
  State<EntryViewScreen> createState() => _EntryViewScreenState();
}

class _EntryViewScreenState extends State<EntryViewScreen> {
  late final QuillController _controller;
  @override
  void initState() {
    super.initState();
    // final json = jsonDecode(context.read<EntryViewCubit>().state.entry!.data);
    _controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.entry.data)),
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
          ),
        ),
        actions: [
          PopupMenuButton(
            elevation: 0.0,
            icon: const Icon(
              Icons.more_vert_outlined,
              color: AppTheme.lightDisabledColor,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  context.read<EntryCubit>().removeEntry(entry: widget.entry);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              )
            ],
          )
        ],
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
                        widget.entry.title,
                        style: const TextStyle(
                            color: AppTheme.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0),
                      ),
                      Text(
                        widget.entry.createdAt.toString(),
                        style: const TextStyle(
                            color: AppTheme.lightDisabledColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                      AppRouter.entryEditScreen,
                      arguments: {
                        // 'diary': widget.diary,
                        'entry': widget.entry
                      }),
                  icon: Icon(
                    Icons.edit,
                    color: AppTheme.lightPrimaryColor,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[400],
                    ))
              ],
            ),
          ),
          const SizedBox(height: 24.0),
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
              autoFocus: false,
              scrollController: ScrollController(),
              padding: EdgeInsets.zero,
              expands: true,
              scrollable: true,
              focusNode: FocusNode(),
              showCursor: false,
              controller: _controller,
              readOnly: true,
            ),
          ))
        ],
      ),
    );
  }
}

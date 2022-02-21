import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/logic/entry/cubit/entry_cubit.dart';
import 'package:my_little_diary/logic/entry_view/cubit/entry_view_cubit.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class EntryViewScreen extends StatefulWidget {
  const EntryViewScreen({Key? key}) : super(key: key);

  @override
  State<EntryViewScreen> createState() => _EntryViewScreenState();
}

class _EntryViewScreenState extends State<EntryViewScreen> {
  late final QuillController _controller;
  @override
  void initState() {
    super.initState();
    final json = jsonDecode(context.read<EntryViewCubit>().state.entry!.data);
    _controller = QuillController(
      document: Document.fromJson(json),
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
    return BlocBuilder<EntryViewCubit, EntryViewState>(
        builder: (context, state) {
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
                          state.entry!.title,
                          style: TextStyle(
                              color: AppTheme.lightPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0),
                        ),
                        Text(
                          state.entry!.createdAt.toString(),
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
                    child: const Text('Edit'),
                  )
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
                controller: _controller,
                readOnly: true,
              ),
            ))
          ],
        ),
      );
    });
  }
}

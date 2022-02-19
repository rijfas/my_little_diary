import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/logic/entry/cubit/entry_cubit.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class EntryCreateScreen extends StatefulWidget {
  const EntryCreateScreen({Key? key}) : super(key: key);

  @override
  State<EntryCreateScreen> createState() => _EntryCreateScreenState();
}

class _EntryCreateScreenState extends State<EntryCreateScreen> {
  late final QuillController _controller;
  String _title = 'Saturday';
  DateTime _date = DateTime.now();
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
    return BlocConsumer<EntryCubit, EntryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EntryLoaded) {
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
                                _title,
                                style: TextStyle(
                                    color: AppTheme.lightPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0),
                              ),
                              Text(
                                _date.toString(),
                                style: TextStyle(
                                    color: AppTheme.lightDisabledColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<EntryCubit>().createEntry(
                                  diary: state.diary!,
                                  title: _title,
                                  data: 'hello',
                                );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRouter.entryListScreen, (route) => false);
                          },
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
                    child: QuillEditor.basic(
                        controller: _controller, readOnly: false),
                  ))
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

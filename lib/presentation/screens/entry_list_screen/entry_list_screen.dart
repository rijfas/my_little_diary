import 'package:flutter/material.dart';
import 'package:my_little_diary/logic/diary/diary_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themes/app_theme.dart';
import '../../../data/models/models.dart';
import '../../components/components.dart' show EntryTile;
import '../../router/app_router.dart';

class EntryListScreen extends StatelessWidget {
  const EntryListScreen({Key? key, required this.diary}) : super(key: key);
  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final entries = <Entry>[
      Entry(
        id: '1',
        diaryId: '1',
        title: 'First Entry',
        createdAt: DateTime.now(),
        data: 'Bla bla',
        color: Colors.blue,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.chevron_left,
              color: AppTheme.lightDisabledColor,
            )),
        title: Text(diary.title),
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
                  context.read<DiaryCubit>().removeDiary(id: diary.id);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              )
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) =>
            EntryTile(entry: entries[index], onOpen: (_) => {}),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        backgroundColor: AppTheme.lightPrimaryColor,
        onPressed: () => Navigator.of(context)
            .pushNamed(AppRouter.entryCreateScreen, arguments: diary),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';
import '../../../data/models/models.dart';
import '../../../logic/diary/diary_cubit.dart';
import '../../../logic/entry/entry_cubit.dart';
import '../../../logic/recent_entries/recent_entries_cubit.dart';
import '../../components/components.dart' show EntryTile;
import '../../router/app_router.dart';

class EntryListScreen extends StatefulWidget {
  const EntryListScreen({Key? key, required this.diary}) : super(key: key);
  final Diary diary;

  @override
  State<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
  @override
  void initState() {
    context.read<EntryCubit>().loadEntries(diaryId: widget.diary.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await context.read<RecentEntriesCubit>().loadRecentEntries();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.read<RecentEntriesCubit>().loadRecentEntries();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                color: AppTheme.lightDisabledColor,
              )),
          title: Text(widget.diary.title),
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
                    context.read<DiaryCubit>().removeDiary(id: widget.diary.id);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                )
              ],
            )
          ],
        ),
        body: BlocBuilder<EntryCubit, EntryState>(
          builder: (context, state) {
            if (state is EntryLoaded) {
              return ListView.builder(
                itemCount: state.entries.length,
                itemBuilder: (context, index) => EntryTile(
                    entry: state.entries[index],
                    onOpen: (entry) => Navigator.of(context)
                            .pushNamed(AppRouter.entryViewScreen, arguments: {
                          'entry': entry,
                          'diary': widget.diary,
                        })),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.create),
          backgroundColor: AppTheme.lightPrimaryColor,
          onPressed: () => Navigator.of(context)
              .pushNamed(AppRouter.entryCreateScreen, arguments: widget.diary),
        ),
      ),
    );
  }
}

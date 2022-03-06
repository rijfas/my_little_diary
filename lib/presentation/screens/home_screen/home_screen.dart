import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';
import '../../../logic/diary/diary_cubit.dart';
import '../../../logic/recent_entries/recent_entries_cubit.dart';
import '../../components/components.dart' show EntryTile;
import '../../router/app_router.dart';
import 'components/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DiaryCubit>().loadDiaries();
    context.read<RecentEntriesCubit>().loadRecentEntries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.settings,
          color: AppTheme.lightDisabledColor,
        ),
        title: const Text('My Little Diary'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouter.entrySearchScreen),
              icon: Icon(
                Icons.search,
                color: AppTheme.lightDisabledColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height - kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const CustomSearchBar(),
                const BoldHeaderText(text: 'Diaries'),
                Expanded(
                  flex: 1,
                  child: BlocBuilder<DiaryCubit, DiaryState>(
                    builder: (context, state) {
                      if (state is DiaryLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.diaries.length + 1,
                          itemBuilder: (context, index) {
                            if (index == (state.diaries.length)) {
                              return DiaryCreateButton(
                                onDiaryCreated: (title, color) => context
                                    .read<DiaryCubit>()
                                    .createDiary(title: title, color: color),
                              );
                            }
                            return DiaryIcon(
                              diary: state.diaries[index],
                              onTap: () => Navigator.of(context).pushNamed(
                                AppRouter.entryListScreen,
                                arguments: state.diaries[index],
                              ),
                            );
                          },
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                const BoldHeaderText(text: 'Recent Entries'),
                Expanded(
                  flex: 2,
                  child: BlocBuilder<RecentEntriesCubit, RecentEntriesState>(
                    builder: (context, state) {
                      if (state is RecentEntriesLoaded) {
                        return ListView.builder(
                          itemCount: state.entries.length,
                          itemBuilder: (context, index) {
                            return EntryTile(
                                entry: state.entries[index],
                                onOpen: (entry) {
                                  Navigator.of(context).pushNamed(
                                      AppRouter.entryViewScreen,
                                      arguments: {'entry': entry});
                                });
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

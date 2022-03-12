import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/data/repositories/settings_repository.dart';
import 'package:my_little_diary/logic/search_entries/search_entries_bloc.dart';
import 'package:my_little_diary/logic/settings/settings_cubit.dart';

import 'core/themes/app_theme.dart';
import 'data/repositories/diary_repository.dart';
import 'data/repositories/entry_repository.dart';
import 'logic/diary/diary_cubit.dart';
import 'logic/entry/entry_cubit.dart';
import 'logic/recent_entries/recent_entries_cubit.dart';
import 'presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => DiaryRepository()),
        RepositoryProvider(create: (_) => EntryRepository()),
        RepositoryProvider(create: (_) => SettingsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DiaryCubit(
              diaryRepository: context.read<DiaryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => EntryCubit(
              entryRepository: context.read<EntryRepository>(),
              diaryRepository: context.read<DiaryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => RecentEntriesCubit(
              entryRepository: context.read<EntryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SearchEntriesBloc(
              entryRepository: context.read<EntryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsCubit(
              settingsRepository: context.read<SettingsRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.homeScreen,
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/data/repositories/entry_repository.dart';
import 'package:my_little_diary/logic/entry/entry_cubit.dart';
import 'package:my_little_diary/presentation/screens/home_screen/components/recent_entry_list/cubit/recent_entry_list_cubit.dart';

import 'core/themes/app_theme.dart';
import 'data/repositories/diary_repository.dart';
import 'logic/diary/diary_cubit.dart';
import 'presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => DiaryRepository()),
        RepositoryProvider(create: (_) => EntryRepository()),
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
            ),
          ),
          BlocProvider(
            create: (context) => RecentEntryListCubit(),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.homeScreen,
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DiaryCubit(
              diaryRepository: context.read<DiaryRepository>(),
            ),
          )
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/core/theme/app_theme.dart';
import 'package:my_little_diary/data/repositories/diary_repository.dart';
import 'package:my_little_diary/logic/diary/diary_bloc.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DiaryRepository(),
      child: BlocProvider(
        create: (context) => DiaryBloc(
          diaryRepository: context.read<DiaryRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.homeScreen,
        ),
      ),
    );
  }
}

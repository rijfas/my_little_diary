import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/logic/diary/cubit/diary_cubit.dart';
import 'package:my_little_diary/logic/entry/cubit/entry_cubit.dart';
import 'package:my_little_diary/logic/entry_view/cubit/entry_view_cubit.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DiaryCubit(),
        ),
        BlocProvider(
          create: (_) => EntryCubit(),
        ),
        BlocProvider(
          create: (_) => EntryViewCubit(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.homeScreen,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}

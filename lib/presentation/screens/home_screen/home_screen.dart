import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/logic/diary/diary_bloc.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiaryBloc>().add(LoadDiaries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Little Diary'),
      ),
      body: BlocBuilder<DiaryBloc, DiaryState>(builder: (context, state) {
        if (state is DiaryLoaded) {
          return ListView.builder(
            itemCount: state.diaries.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                state.diaries[index].title,
              ),
              tileColor: state.diaries[index].color,
              onTap: () => Navigator.of(context).pushNamed(
                AppRouter.diaryScreen,
                arguments: state.diaries[index],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRouter.diaryScreen)),
    );
  }
}

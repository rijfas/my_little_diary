import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/logic/entry/cubit/entry_cubit.dart';
import 'package:my_little_diary/logic/entry_create/cubit/entry_create_cubit.dart';
import 'package:my_little_diary/logic/entry_view/cubit/entry_view_cubit.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class EntryListScreen extends StatelessWidget {
  const EntryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EntryCreateCubit, EntryCreateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocListener<EntryViewCubit, EntryViewState>(
        listener: (context, state) {
          if (state is EntryViewLoaded) {
            Navigator.of(context).pushNamed(AppRouter.entryViewScreen);
          }
        },
        child: BlocBuilder<EntryCubit, EntryState>(builder: (context, state) {
          if (state is EntryLoaded) {
            return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: AppTheme.lightDisabledColor,
                      )),
                  title: Text(state.diary!.title)),
              body: ListView.builder(
                itemCount: state.entries.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => context.read<EntryViewCubit>().loadEntryView(
                      diary: state.diary!, entry: state.entries[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: state.diary!.color,
                              borderRadius: BorderRadius.circular(5.0)),
                          width: 12.0,
                          height: 40.0,
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.entries[index].createdAt.toString(),
                                style: const TextStyle(
                                  color: AppTheme.lightDisabledColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                state.entries[index].title,
                                style: const TextStyle(
                                  color: AppTheme.lightPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.create),
                backgroundColor: AppTheme.lightPrimaryColor,
                onPressed: () => Navigator.of(context)
                    .pushNamed(AppRouter.entryCreateScreen),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}

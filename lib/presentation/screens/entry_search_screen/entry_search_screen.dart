import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/logic/search_entries/search_entries_bloc.dart';
import 'package:my_little_diary/presentation/components/components.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';
import 'package:my_little_diary/presentation/screens/home_screen/components/custom_search_bar.dart';

class EntrySearchScreen extends StatefulWidget {
  const EntrySearchScreen({Key? key}) : super(key: key);

  @override
  State<EntrySearchScreen> createState() => _EntrySearchScreenState();
}

class _EntrySearchScreenState extends State<EntrySearchScreen> {
  late final TextEditingController _textEditingController;

  bool _showClearButton = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: AppTheme.lightDisabledColor,
          ),
        ),
        title: TextField(
          controller: _textEditingController,
          onChanged: (value) {
            if (value != '') {
              setState(() {
                _showClearButton = true;
                context
                    .read<SearchEntriesBloc>()
                    .add(SearchStarted(query: value));
              });
            } else {
              setState(() {
                _showClearButton = false;
                context.read<SearchEntriesBloc>().add(SearchCleared());
              });
            }
          },
          autofocus: true,
          decoration: const InputDecoration(
              focusColor: AppTheme.lightDisabledColor,
              hintStyle: TextStyle(
                  color: AppTheme.lightDisabledColor,
                  fontWeight: FontWeight.bold),
              hintText: 'Search Diaries',
              border: InputBorder.none),
        ),
        actions: [
          if (_showClearButton)
            IconButton(
                onPressed: () {
                  context.read<SearchEntriesBloc>().add(SearchCleared());
                  _textEditingController.clear();
                  setState(() {
                    _showClearButton = false;
                  });
                },
                icon: const Icon(
                  Icons.clear,
                  color: AppTheme.lightDisabledColor,
                ))
        ],
      ),
      body: BlocBuilder<SearchEntriesBloc, SearchEntriesState>(
          builder: ((context, state) {
        if (state is SearchEntriesInitial) {
          return const Text('Search...');
        } else if (state is SearchEntriesLoaded) {
          return ListView.builder(
            itemCount: state.entries.length,
            itemBuilder: (context, index) {
              return EntryTile(
                  entry: state.entries[index],
                  onOpen: (entry) {
                    Navigator.of(context).pushNamed(AppRouter.entryViewScreen,
                        arguments: {'entry': entry});
                  });
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      })),
    );
  }
}

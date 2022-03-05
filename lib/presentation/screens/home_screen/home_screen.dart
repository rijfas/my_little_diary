import 'package:flutter/material.dart';
import 'package:my_little_diary/data/models/entry.dart';

import '../../../core/themes/app_theme.dart';
import '../../../data/models/diary.dart';
import 'components/diary_create_button.dart';
import 'components/diary_icon.dart';
import 'components/entry_tile.dart';
import 'components/custom_search_bar.dart';
import 'components/bold_header_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final diaries = <Diary>[
    Diary(id: '1', createdAt: DateTime.now(), title: 'Test', color: Colors.blue)
  ];
  final entries = <Entry>[
    Entry(
        id: '1',
        diaryId: '1',
        title: 'First Entry',
        createdAt: DateTime.now(),
        data: 'Bla bla')
  ];
  @override
  void initState() {
    // context.read<DiaryCubit>().loadDiaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Little Diary'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height - kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomSearchBar(),
                const BoldHeaderText(text: 'Diaries'),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: diaries.length + 1,
                    itemBuilder: (context, index) {
                      if (index == (diaries.length)) {
                        return DiaryCreateButton(
                          onDiaryCreated: (title, color) {
                            print(title + '$color');
                          },
                        );
                      }
                      return DiaryIcon(
                        diary: diaries[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
                const BoldHeaderText(text: 'Recent Entries'),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      return EntryTile(
                        entry: entries[index],
                        onOpen: (entry) => print,
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

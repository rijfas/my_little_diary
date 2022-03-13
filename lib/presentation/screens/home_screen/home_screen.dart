import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_little_diary/core/utils/assets.dart';

import '../components/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_little_diary/core/theme/app_theme.dart';
import 'package:my_little_diary/logic/diary/diary_bloc.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    context.read<DiaryBloc>().add(LoadDiaries());
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const Icon(FontAwesomeIcons.feather),
        title: const Text('My Little Diary'),
        actions: [
          AnimSearchBar(
              autoFocus: true,
              helpText: "Search Diaries...",
              color: AppTheme.lightSecondaryColor,
              rtl: true,
              width: size.width,
              closeSearchOnSuffixTap: true,
              textController: _searchController,
              onSearch: (value) =>
                  context.read<DiaryBloc>().add(SearchDiary(query: value)),
              onClose: () => context.read<DiaryBloc>().add(LoadDiaries()),
              onSuffixTap: () {
                _searchController.clear();
                context.read<DiaryBloc>().add(LoadDiaries());
              })
        ],
      ),
      body: BlocBuilder<DiaryBloc, DiaryState>(builder: (context, state) {
        if (state is DiaryLoaded) {
          if (state.diaries.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  (_searchController.value.text != '')
                      ? Assets.noneImage
                      : Assets.emptyImage,
                  height: size.height * 0.15,
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (_searchController.value.text != '')
                      ? [
                          Text(
                              'No diary with title like "${_searchController.value.text}"'),
                        ]
                      : const [
                          Text('create a new diary using '),
                          Icon(
                            FontAwesomeIcons.feather,
                            size: 14.0,
                            color: AppTheme.lightPrimaryColor,
                          )
                        ],
                )
              ],
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: state.diaries.length,
              itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: state.diaries[index].color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          AppRouter.diaryScreen,
                          arguments: state.diaries[index]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.book,
                            size: 64.0,
                            color: state.diaries[index].color,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            state.diaries[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            DateFormat("dd/MM/y")
                                .format(state.diaries[index].createdAt),
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        }
        return const Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(FontAwesomeIcons.feather),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRouter.diaryScreen)),
    );
  }
}

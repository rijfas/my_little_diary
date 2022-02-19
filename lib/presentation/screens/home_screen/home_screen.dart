import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/logic/diary/cubit/diary_cubit.dart';
import 'package:my_little_diary/logic/entry/cubit/entry_cubit.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DiaryCubit>().loadDiaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<EntryCubit, EntryState>(
      listener: (context, state) {
        if (state is EntryLoading) {
          Navigator.of(context).pushNamed(AppRouter.entryListScreen);
        }
      },
      child: Scaffold(
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: TextField(
                            showCursor: false,
                            decoration: InputDecoration(
                                focusColor: AppTheme.lightDisabledColor,
                                hintStyle: TextStyle(
                                    color: AppTheme.lightDisabledColor,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Search Diaries',
                                border: InputBorder.none),
                          ),
                        ),
                        Icon(
                          Icons.search,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Diaries',
                    style: TextStyle(
                        color: AppTheme.lightPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: BlocBuilder<DiaryCubit, DiaryState>(
                        builder: (context, state) {
                      if (state is DiaryLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.diaries.length + 1,
                          itemBuilder: (context, index) {
                            if (index == (state.diaries.length)) {
                              return InkWell(
                                onTap: () {
                                  final _controller = TextEditingController();
                                  MaterialColor _selectedColor = Colors.blue;
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            backgroundColor:
                                                AppTheme.lightSecondaryColor,
                                            title:
                                                const Text('Create New Diary'),
                                            content: RoundedTextFieldWithColor(
                                              controller: _controller,
                                              onColorSelected: (color) =>
                                                  _selectedColor = color,
                                              selectedColor: _selectedColor,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<DiaryCubit>()
                                                      .createDiary(
                                                          title: _controller
                                                              .value.text,
                                                          color:
                                                              _selectedColor);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Create'),
                                              )
                                            ],
                                          ));
                                },
                                child: Opacity(
                                  opacity: 0.33,
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(8.0),
                                              width: size.width * 0.33,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(1, 1),
                                                            blurRadius: 4.0)
                                                      ],
                                                      color: Colors.grey[100],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        size.width * 0.33 * 0.1,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'New Diary',
                                              style: TextStyle(
                                                color:
                                                    AppTheme.lightDisabledColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: AppTheme.lightPrimaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                context
                                    .read<EntryCubit>()
                                    .loadEntries(diary: state.diaries[index]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: size.width * 0.33,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4.0)
                                              ],
                                              color: state
                                                  .diaries[index].color[100],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.33 * 0.1,
                                            color: state.diaries[index].color,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      state.diaries[index].title,
                                      style: const TextStyle(
                                        color: AppTheme.lightDisabledColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                  const Text(
                    'Recent Entries',
                    style: TextStyle(
                        color: AppTheme.lightPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
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
                                      '10:00 AM',
                                      style: TextStyle(
                                        color: AppTheme.lightDisabledColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      'November 15',
                                      style: TextStyle(
                                        color: AppTheme.lightPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedTextFieldWithColor extends StatefulWidget {
  const RoundedTextFieldWithColor({
    Key? key,
    required this.controller,
    required this.onColorSelected,
    this.selectedColor = Colors.blue,
  }) : super(key: key);
  final Color selectedColor;
  final TextEditingController controller;
  final Function(MaterialColor) onColorSelected;
  @override
  _RoundedTextFieldWithColorState createState() =>
      _RoundedTextFieldWithColorState();
}

class _RoundedTextFieldWithColorState extends State<RoundedTextFieldWithColor> {
  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedColor;
  }

  late Color _selectedColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  hintText: 'Enter title',
                  hintStyle: TextStyle(
                    color: AppTheme.lightDisabledColor,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                )),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Select Color'),
                  content: BlockPicker(
                      pickerColor: _selectedColor,
                      onColorChanged: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                        widget.onColorSelected(color as MaterialColor);
                        Navigator.of(context).pop();
                      }),
                ),
              );
            },
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: _selectedColor,
            ),
          )
        ],
      ),
    );
  }
}

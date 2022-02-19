import 'package:flutter/material.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Diaries',
                      style: TextStyle(
                          color: AppTheme.lightPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.more_horiz,
                        ))
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        width: size.width * 0.33,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))),
                            ),
                            Container(
                              width: size.width * 0.33 * 0.1,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Entries',
                      style: TextStyle(
                          color: AppTheme.lightPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    IconButton(
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.more_horiz,
                        ))
                  ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.lightPrimaryColor,
        child: const Icon(Icons.create),
        onPressed: () => Navigator.of(context).pushNamed(AppRouter.diaryScreen),
      ),
    );
  }
}

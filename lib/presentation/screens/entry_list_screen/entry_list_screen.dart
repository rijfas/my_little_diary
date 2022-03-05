import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/presentation/router/app_router.dart';

class EntryListScreen extends StatelessWidget {
  const EntryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.chevron_left,
                color: AppTheme.lightDisabledColor,
              )),
          title: Text('Title Here')),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) => InkWell(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
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
                        'bla bla',
                        style: const TextStyle(
                          color: AppTheme.lightDisabledColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        'bla bla 2',
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
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRouter.entryCreateScreen),
      ),
    );
  }
}

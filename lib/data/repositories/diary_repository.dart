import 'package:hive/hive.dart';

import '../models/diary.dart';

class DiaryRepository {
  Future<List<Diary>> getAllDiaries() async {
    final Box box = await Hive.openBox('diaries');
    List<Diary> diaries = <Diary>[];
    for (var element in box.values) {
      diaries.add(element as Diary);
    }
    await box.close();
    diaries.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
    return diaries;
  }

  Future<void> addDiary(Diary diary) async {
    final Box box = await Hive.openBox('diaries');
    await box.put(diary.id, diary);
    await box.close();
  }

  Future<void> removeDiary(String id) async {
    final Box box = await Hive.openBox('diaries');
    await box.delete(id);
    await box.close();
  }
}

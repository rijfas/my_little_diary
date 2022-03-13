import 'package:hive/hive.dart';
import 'package:my_little_diary/data/models/diary.dart';

class DiaryRepository {
  Future<List<Diary>> getAllDiaries() async {
    final box = await Hive.openBox('diaries');
    final List<Diary> diaries = box.values.map((e) => e as Diary).toList();
    await box.close();
    return diaries;
  }

  Future<void> addDiary(Diary diary) async {
    final box = await Hive.openBox('diaries');
    await box.put(diary.id, diary);
    await box.close();
  }

  Future<void> removeDiary(Diary diary) async {
    final box = await Hive.openBox('diaries');
    box.delete(diary.id);
    await box.close();
  }
}

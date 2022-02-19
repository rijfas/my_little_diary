import 'package:my_little_diary/data/models/diary.dart';

class DiaryRepository {
  final _diaries = <Diary>[];

  Future<List<Diary>> getAllDiaries() async {
    return Future.delayed(const Duration(milliseconds: 100), () => _diaries);
  }

  Future<void> addDiary(Diary diary) async {
    _diaries.add(diary);
    return Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> removeDiary(String id) async {
    _diaries.removeWhere((element) => element.id == id);
    return Future.delayed(const Duration(milliseconds: 100));
  }
}

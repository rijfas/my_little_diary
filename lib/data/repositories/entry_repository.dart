import 'package:my_little_diary/data/models/entry.dart';

class EntryRepository {
  final _entries = <Entry>[];

  Future<List<Entry>> getAllEntries() async {
    return Future.delayed(const Duration(milliseconds: 100), () => _entries);
  }

  Future<List<Entry>> getEntries({required String diaryId}) async {
    final entries =
        _entries.where((element) => element.diaryId == diaryId).toList();
    return Future.delayed(const Duration(milliseconds: 100), () => entries);
  }

  Future<void> addEntry({required Entry entry}) async {
    _entries.add(entry);
    return Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> removeEntry({required String id}) async {
    _entries.removeWhere((element) => element.id == id);
    return Future.delayed(const Duration(milliseconds: 100));
  }
}

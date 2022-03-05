import 'package:hive/hive.dart';
import 'package:my_little_diary/data/models/entry.dart';

class EntryRepository {
  Future<List<Entry>> getRecentEntries() async {
    final box = await Hive.openBox('entries');
    List<Entry> entries = <Entry>[];
    for (Entry element in box.values) {
      entries.add(element);
    }
    await box.close();
    entries.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
    return entries.take(5).toList();
  }

  Future<List<Entry>> getEntries({required String diaryId}) async {
    final box = await Hive.openBox('entries');
    List<Entry> entries = <Entry>[];
    for (Entry element in box.values) {
      if (element.diaryId == diaryId) {
        entries.add(element);
      }
    }
    await box.close();
    entries.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
    return entries;
  }

  Future<void> addEntry({required Entry entry}) async {
    final box = await Hive.openBox('entries');
    await box.put(entry.id, entry);
    await box.close();
  }

  Future<void> removeEntry({required String id}) async {
    final box = await Hive.openBox('entries');
    await box.delete(id);
    await box.close();
  }
}

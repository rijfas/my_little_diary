import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/models.dart';
import '../../data/repositories/entry_repository.dart';

part 'entry_state.dart';

class EntryCubit extends Cubit<EntryState> {
  EntryCubit({required this.entryRepository}) : super(EntryInitial());
  final EntryRepository entryRepository;

  void loadEntries({required String diaryId}) async {
    emit(EntryLoading());
    final entries = await entryRepository.getEntries(diaryId: diaryId);
    emit(EntryLoaded(entries: entries));
  }

  Future<void> loadRecentEntries() async {
    emit(EntryLoading());
    final entries = await entryRepository.getRecentEntries();
    emit(EntryLoaded(entries: entries));
  }

  void addEntry(
      {required Diary diary, required String title, required String data}) {
    const uuid = Uuid();
    final entry = Entry(
        id: uuid.v4(),
        diaryId: diary.id,
        title: title,
        createdAt: DateTime.now(),
        color: diary.color,
        data: data);
    entryRepository.addEntry(entry: entry);
    loadEntries(diaryId: diary.id);
  }

  void editEntry({
    required Diary diary,
    required Entry oldEntry,
    required String title,
    required String data,
  }) {
    final entry = Entry(
      id: oldEntry.id,
      diaryId: diary.id,
      title: title,
      createdAt: oldEntry.createdAt,
      color: diary.color,
      data: data,
    );
    entryRepository.removeEntry(id: oldEntry.id);
    entryRepository.addEntry(entry: entry);
    loadEntries(diaryId: diary.id);
  }

  void removeEntry({required Entry entry}) {
    entryRepository.removeEntry(id: entry.id);
    loadEntries(diaryId: entry.diaryId);
  }
}

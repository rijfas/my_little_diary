import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/data/repositories/entry_repository.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/entry.dart';

part 'entry_state.dart';

class EntryCubit extends Cubit<EntryState> {
  final EntryRepository _repository = EntryRepository();
  EntryCubit() : super(const EntryInitial());

  void loadEntries({required Diary diary}) async {
    emit(EntryLoading());
    final entries = await _repository.getEntries(diaryId: diary.id);
    emit(EntryLoaded(diary: diary, entries: entries));
  }

  void createEntry({
    required Diary diary,
    required String title,
    required String data,
  }) async {
    // emit(EntryLoading());
    const uuid = Uuid();

    final entry = Entry(
      id: uuid.v1(),
      diaryId: diary.id,
      title: title,
      createdAt: DateTime.now(),
      data: data,
    );

    await _repository.addEntry(entry: entry);

    loadEntries(diary: diary);
  }
}

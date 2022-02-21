import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/data/models/entry.dart';

part 'entry_view_state.dart';

class EntryViewCubit extends Cubit<EntryViewState> {
  EntryViewCubit() : super(EntryViewInitial());

  void loadEntryView({required Diary diary, required Entry entry}) {
    emit(EntryViewLoaded(diary: diary, entry: entry));
  }
}

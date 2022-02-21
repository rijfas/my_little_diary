import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_little_diary/data/models/diary.dart';

part 'entry_create_state.dart';

class EntryCreateCubit extends Cubit<EntryCreateState> {
  EntryCreateCubit() : super(EntryCreateInitial());

  void createEntry({required Diary diary}) {
    emit(EntryCreateLoading(diary: diary));
  }
}

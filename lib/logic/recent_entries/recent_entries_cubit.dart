import 'package:bloc/bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/entry_repository.dart';

part 'recent_entries_state.dart';

class RecentEntriesCubit extends Cubit<RecentEntriesState> {
  final EntryRepository entryRepository;
  RecentEntriesCubit({required this.entryRepository})
      : super(RecentEntriesInitial());

  Future<void> loadRecentEntries() async {
    emit(RecentEntriesLoading());
    final entries = await entryRepository.getRecentEntries();
    emit(RecentEntriesLoaded(entries: entries));
  }
}

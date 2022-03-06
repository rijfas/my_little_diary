import 'package:bloc/bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/entry_repository.dart';

part 'search_entries_event.dart';
part 'search_entries_state.dart';

class SearchEntriesBloc extends Bloc<SearchEntriesEvent, SearchEntriesState> {
  final EntryRepository entryRepository;
  SearchEntriesBloc({required this.entryRepository})
      : super(SearchEntriesInitial()) {
    on<SearchStarted>((event, emit) async {
      emit(SearchEntriesLoading());
      final entries =
          await entryRepository.getEntriesLike(pattern: event.query);
      emit(SearchEntriesLoaded(entries: entries));
    });

    on<SearchCleared>((event, emit) async {
      emit(SearchEntriesInitial());
    });
  }
}

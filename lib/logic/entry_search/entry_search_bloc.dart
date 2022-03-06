import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'entry_search_event.dart';
part 'entry_search_state.dart';

class EntrySearchBloc extends Bloc<EntrySearchEvent, EntrySearchState> {
  EntrySearchBloc() : super(EntrySearchInitial()) {
    on<EntrySearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

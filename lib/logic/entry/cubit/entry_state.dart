part of 'entry_cubit.dart';

@immutable
abstract class EntryState {
  final Diary? diary;
  final List<Entry> entries;
  const EntryState({
    this.diary,
    this.entries = const [],
  });
}

class EntryInitial extends EntryState {
  const EntryInitial() : super();
}

class EntryLoading extends EntryState {}

class EntryLoaded extends EntryState {
  const EntryLoaded({
    required Diary diary,
    required List<Entry> entries,
  }) : super(diary: diary, entries: entries);
}

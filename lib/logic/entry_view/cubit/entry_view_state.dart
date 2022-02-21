part of 'entry_view_cubit.dart';

@immutable
abstract class EntryViewState {
  const EntryViewState({
    this.diary,
    this.entry,
  });
  final Diary? diary;
  final Entry? entry;
}

class EntryViewInitial extends EntryViewState {}

class EntryViewLoading extends EntryViewState {}

class EntryViewLoaded extends EntryViewState {
  const EntryViewLoaded({
    required Diary diary,
    required Entry entry,
  }) : super(diary: diary, entry: entry);
}

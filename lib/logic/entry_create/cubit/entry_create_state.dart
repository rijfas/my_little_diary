part of 'entry_create_cubit.dart';

@immutable
abstract class EntryCreateState {
  final Diary? diary;
  const EntryCreateState({this.diary});
}

class EntryCreateInitial extends EntryCreateState {}

class EntryCreateLoading extends EntryCreateState {
  const EntryCreateLoading({required Diary diary}) : super(diary: diary);
}

class EntryCreateCompleted extends EntryCreateState {}

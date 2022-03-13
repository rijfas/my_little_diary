part of 'diary_bloc.dart';

abstract class DiaryEvent {}

class LoadDiaries extends DiaryEvent {}

class AddDiary extends DiaryEvent {
  final Diary diary;
  AddDiary({required this.diary});
}

class RemoveDiary extends DiaryEvent {
  final Diary diary;
  RemoveDiary({required this.diary});
}

class SearchDiary extends DiaryEvent {
  final String query;
  SearchDiary({required this.query});
}

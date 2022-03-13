part of 'diary_bloc.dart';

abstract class DiaryState {}

class DiaryInitial extends DiaryState {}

class DiaryLoading extends DiaryState {}

class DiaryLoaded extends DiaryState {
  final List<Diary> diaries;

  DiaryLoaded({required this.diaries});
}

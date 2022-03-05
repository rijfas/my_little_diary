part of 'diary_cubit.dart';

abstract class DiaryState {}

class DiaryInitial extends DiaryState {}

class DiaryLoading extends DiaryState {}

class DiaryLoaded extends DiaryState {
  DiaryLoaded({required this.diaries});
  final List<Diary> diaries;
}

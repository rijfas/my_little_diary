import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/data/repositories/diary_repository.dart';
import 'package:uuid/uuid.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  final DiaryRepository _repository = DiaryRepository();
  DiaryCubit() : super(DiaryInitial());

  void loadDiaries() async {
    emit(DiaryLoading());
    final diaries = await _repository.getAllDiaries();
    emit(DiaryLoaded(diaries: diaries));
  }

  void createDiary(
      {required String title, required MaterialColor color}) async {
    emit(DiaryLoading());
    const uuid = Uuid();
    final diary = Diary(
      id: uuid.v1(),
      createdAt: DateTime.now(),
      title: title,
      color: color,
    );
    await _repository.addDiary(diary);
    loadDiaries();
  }
}

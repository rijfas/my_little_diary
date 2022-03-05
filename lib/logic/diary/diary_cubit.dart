import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/diary.dart';
import '../../data/repositories/diary_repository.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit({required this.diaryRepository}) : super(DiaryInitial());
  final DiaryRepository diaryRepository;

  void loadDiaries() async {
    emit(DiaryLoading());
    final diaries = await diaryRepository.getAllDiaries();
    emit(DiaryLoaded(diaries: diaries));
  }

  void createDiary({required String title, required Color color}) async {
    const uuid = Uuid();
    Diary diary = Diary(
      id: uuid.v4(),
      createdAt: DateTime.now(),
      title: title,
      color: color,
    );
    diaryRepository.addDiary(diary);
    loadDiaries();
  }

  void removeDiary({required String id}) async {
    diaryRepository.removeDiary(id);
    loadDiaries();
  }
}

import 'package:bloc/bloc.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/data/repositories/diary_repository.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final DiaryRepository diaryRepository;
  DiaryBloc({required this.diaryRepository}) : super(DiaryInitial()) {
    on<LoadDiaries>((event, emit) async {
      emit(DiaryLoading());
      final diaries = await diaryRepository.getAllDiaries();
      emit(DiaryLoaded(diaries: diaries));
    });

    on<AddDiary>((event, emit) async {
      await diaryRepository.addDiary(event.diary);
      add(LoadDiaries());
    });

    on<RemoveDiary>((event, emit) async {
      await diaryRepository.removeDiary(event.diary);
      add(LoadDiaries());
    });
  }
}

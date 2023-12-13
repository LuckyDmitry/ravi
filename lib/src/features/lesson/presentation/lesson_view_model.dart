import "package:flutter/material.dart";
import "../domain/lesson_use_case.dart";
import "lesson_view.dart";


class LessonViewModel extends ChangeNotifier {
  final LessonUseCase _lessonUseCase;
  List<Lesson>? lessons;
  SubLesson? selectedSublesson;

  LessonViewModel(this._lessonUseCase);

  String? errorMessage;

  void fetchLessons(String courceId) async {
    try {
      lessons = await _lessonUseCase.getLessons(courceId);
      selectedSublesson = lessons?.first.sublessons.firstOrNull;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  void onSubLessonTap(SubLesson sublesson) { 
    selectedSublesson = sublesson;
    // Iterate through each lesson and sublesson
  for (var lesson in lessons ?? []) {
    for (var sublessonItem in lesson.sublessons) {
      // Update isSelected flag
      sublessonItem.isSelected = sublessonItem == sublesson;
    }
  }
    notifyListeners();
  }
}

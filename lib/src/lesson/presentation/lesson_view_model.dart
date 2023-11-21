import "package:flutter/material.dart";
import "package:ravi/src/courses/data/course_dto.dart";
import "package:ravi/src/lesson/domain/lesson_use_case.dart";
import "package:ravi/src/lesson/presentation/lesson_view.dart";


class LessonViewModel extends ChangeNotifier {
  final LessonUseCase _lessonUseCase;
  List<Lesson>? lessons;
  SubLesson? selectedSublesson;

  LessonViewModel(this._lessonUseCase);

  String? errorMessage;

  void fetchLessons() async {
    try {
      lessons = await _lessonUseCase.getLessons();
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

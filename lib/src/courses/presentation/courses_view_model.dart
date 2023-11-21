import "package:flutter/material.dart";
import "package:ravi/src/courses/data/course_dto.dart";
import "package:ravi/src/courses/domain/courses_use_case.dart";


class CoursesViewModel extends ChangeNotifier {
  final CoursesUseCase coursesUseCase;

  CoursesViewModel(this.coursesUseCase);

  String? errorMessage;

  List<CourseDTO> courses = [];
  bool isLoading = false;

  void fetchCourses() async {
    try {
      isLoading = true;
      courses = await coursesUseCase.getCourses();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }
}

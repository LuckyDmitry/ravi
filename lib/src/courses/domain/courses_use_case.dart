import "package:ravi/src/courses/data/course_dto.dart";
import 'package:ravi/src/courses/data/course_repository.dart';
import "package:ravi/src/service_locator.dart";

class CoursesUseCase {

  final CourseRepository courseRepository = services<CourseRepository>();

  Future<List<CourseDTO>> getCourses() async {
    return await courseRepository.getCourses();
  }
}
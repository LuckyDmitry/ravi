import "package:ravi/src/courses/data/course_dto.dart";

class CourseRepository {
  
  Future<List<CourseDTO>> getCourses() async {
    
    await Future.delayed(const Duration(seconds: 1));

    return [
  CourseDTO(title: "AndroidSDK", blocks: List.of([
    CourseBlockDTO(title: "First", description: "asdsa", pages: List.of([
      PagePreviewDTO(title: "first", completed: false, containsTask: false)
    ])),
    
  ])),
CourseDTO(title: "Kotlin", blocks: List.of([
    CourseBlockDTO(title: "First", description: "asdsa", pages: List.of([
      PagePreviewDTO(title: "first", completed: false, containsTask: false)
    ])),
  ])),
  CourseDTO(title: "Interviews", blocks: List.of([
    CourseBlockDTO(title: "First", description: "asdsa", pages: List.of([
      PagePreviewDTO(title: "first", completed: false, containsTask: false)
    ])),
    
  ]))
];
  }
}
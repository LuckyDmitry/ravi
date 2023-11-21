import "package:ravi/src/courses/data/course_dto.dart";
import "package:ravi/src/lesson/presentation/lesson_view.dart";

class LessonUseCase {

  String courseId;

  LessonUseCase({required this.courseId});

  Future<List<Lesson>> getLessons() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.of([
      Lesson(title: "Activity", sublessons: List.of([
      SubLesson(title: "Activity", taskDescription: """
      
This is a basic example of Kotlin code demonstrating a simple function.

## Function Description

The function `printMessage` takes a string as an input and prints it to the console. This is a demonstration of a basic function in Kotlin.

## Kotlin Code

```code
fun printMessage(message: String) {
    println(message)
}

fun main() {
    printMessage("Hello, Kotlin!")
}
      
      
      """, isCodingTask: false, isEnabled: true, isSelected: true),
      SubLesson(title: "Activity2", taskDescription: "You need to finish", isCodingTask: false, isEnabled: true),
      SubLesson(title: "Activity3", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false, isCompleted: true),
      SubLesson(title: "Activity4", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity5", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity6", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false)
    ])),

     Lesson(title: "Provider", sublessons: List.of([
      SubLesson(title: "Activity1", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity2", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity3", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity4", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity5", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false),
      SubLesson(title: "Activity6", taskDescription: "You need to finish", isCodingTask: false, isEnabled: false)
    ])),
    ]);
  }
}
import "course_dto.dart";

class CoursesRepository {
  
  Future<List<CoursePreviewDTO>> getCourses() async {
    
    await Future.delayed(const Duration(seconds: 1));
    return [
      CoursePreviewDTO(
          id: "1",
          title: "AndroidSDK",
          description: "Курс по андройд разработке",
          imgUrl: "https://cdn.stepik.net/media/users/470788160/avatar.png"
      ),
      CoursePreviewDTO(
          id: "2",
          title: "Koltin",
          description: "Курс по Котлину",
          imgUrl: "https://cdn.stepik.net/media/users/142001224/avatar.png"
      ),
      CoursePreviewDTO(
          id: "3",
          title: "Собеседования",
          description: "Прохождение собеседований на отлично",
          imgUrl: "https://cdn.stepik.net/media/users/37228178/avatar.png"
      ),
    ];
  }

  Future<CourseSchemeDTO> getCourceScheme(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return CourseSchemeDTO(
        id: "1",
        title: "AndroidSDK",
        continueAt: BlockAndPage(
          blockNumber: 1,
          pageNumber: 2
        ),
        blocks: [
          CourseBlockSchemeDTO(
              number: 1,
              title: "Activity",
              isCompleted: true,
              pages: [
                PagePreviewDTO(number: 1, title: "Lifecycle", completed: true),
                PagePreviewDTO(number: 2, title: "Methods", completed: true),
                PagePreviewDTO(number: 3, title: "Memory leaks", completed: true)
              ]
          ),
          CourseBlockSchemeDTO(
              number: 2,
              title: "Service",
              isCompleted: false,
              pages: [
                PagePreviewDTO(number: 1, title: "Lifecycle", completed: true),
                PagePreviewDTO(number: 2, title: "Bound or Started", completed: false),
                PagePreviewDTO(number: 3, title: "Foreground service", completed: false)
              ]
          )
        ]
    );
  }

  Future<PageDTO> getPage(String courceId, int blockNumber, int pageNumber) async {
    await Future.delayed(const Duration(seconds: 1));
    return PageDTO(
        number: 2,
        title: "Lifecycle",
        content: """
      
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
      
      
      """,
    );
  }
}
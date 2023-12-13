import "course_dto.dart";

class CourseRepository {
  
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
}
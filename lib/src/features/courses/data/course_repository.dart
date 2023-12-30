import "course_dto.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class CoursesRepositoryError extends Error {
  final String message;

  CoursesRepositoryError(this.message);

  @override
  String toString() {
    return 'MyCustomError: $message';
  }
}

class CoursesRepository {
  Future<List<CoursePreviewDTO>> getCourses() async {
    final courseRef = FirebaseFirestore.instance
        .collection('courses')
        .withConverter<CoursePreviewDTO>(
          fromFirestore: (snapshots, _) =>
              CoursePreviewDTO.fromJson(snapshots.data()!),
          toFirestore: (course, _) => course.toJson(),
        );
    final querySnapshot = await courseRef.get();

    List<CoursePreviewDTO> courses =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    return courses;
  }

  Future<CourseSchemeDTO> getCourceScheme(String courseId) async {
    final courseSchemeRef = FirebaseFirestore.instance
        .collection('courses_schemes')
        .withConverter<CourseSchemeDTO>(
          fromFirestore: (snapshots, _) =>
              CourseSchemeDTO.fromJson(snapshots.data()!),
          toFirestore: (course, _) => course.toJson(),
        );

    try {
      final documentSnapshot = await courseSchemeRef.doc(courseId).get();

      // You can access its data using documentSnapshot.data()
      final courseSchemeDTO = documentSnapshot.data()!;
      return courseSchemeDTO;
    } catch (e) {
      print(e);
      throw CoursesRepositoryError("Couldn't load courses. Try again later");
    }
  }

  Future<PageDTO> getPage(String pageId) async {
    final pageRef = FirebaseFirestore.instance
        .collection('course_pages')
        .withConverter<PageDTO>(
          fromFirestore: (snapshots, _) => PageDTO.fromJson(snapshots.data()!),
          toFirestore: (course, _) => course.toJson(),
        );

    try {
      final documentSnapshot = await pageRef.doc(pageId).get();

      final pageDTO = documentSnapshot.data()!;
      pageDTO.content = pageDTO.content.replaceAll("\\n ", "\n");
      return pageDTO;
    } catch (e) {
      print(e);
      throw CoursesRepositoryError("Couldn't load courses. Try again later");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ravi/src/common/router/router.dart';
import 'package:ravi/src/common/ui/app_bar_widget.dart';
import '../../../service_locator.dart';
import '../data/course_dto.dart';
import '../data/course_repository.dart';
import 'cource_item.dart';

class CoursesPage extends StatefulWidget {
  static const String screen = "/courses";

  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesView createState() => _CoursesView();
}

class _CoursesView extends State<CoursesPage> {
  final CoursesRepository courseRepository = services<CoursesRepository>();

  List<CoursePreviewDTO> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    courseRepository.getCourses().then((courses) => {
      setState(() {
        _courses = courses;
        _isLoading = false;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Display loading indicator when data is being loaded
      return Scaffold(
          appBar: FMAppBarWidget.showLogin(),
          body: WillPopScope(
              onWillPop: () async => Future.value(false),
              child: const Center(child: CircularProgressIndicator())));
    } else {
      // Display course grid when data is not loading
      return Scaffold(
          appBar: FMAppBarWidget.showLogin(),
          body: WillPopScope(
              onWillPop: () async => Future.value(false),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Adjust number of columns as needed
                  childAspectRatio: 1.5,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  var course = _courses[index];
                  return Material(
                      child: InkWell(
                          onTap: () {
                            FMRouters.navigateToCource(context, course.id);
                          },
                          child: CourseItem(
                            title: course.title,
                            description: course.description,
                            iconUrl: course.imgUrl,
                          )
                      ));
                },
              )));
    }
  }
}

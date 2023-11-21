import 'package:flutter/material.dart';
import 'package:ravi/src/courses/domain/courses_use_case.dart';
import 'package:ravi/src/courses/presentation/courses_view_model.dart';
import 'package:ravi/src/lesson/presentation/lesson_view.dart';


class CoursesView extends StatefulWidget {
  final CoursesViewModel viewModel = CoursesViewModel(CoursesUseCase());

  static const String screen = "/courses";

  CoursesView({Key? key}) : super(key: key);

  @override
  _CoursesView createState() => _CoursesView();
}

class _CoursesView extends State<CoursesView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChanged);
    widget.viewModel.fetchCourses();
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    // Called whenever the view model calls `notifyListeners`.
    setState(() {});
  }

  @override
Widget build(BuildContext context) {
  if (widget.viewModel.isLoading) {
    // Display loading indicator when data is being loaded
    return Center(child: CircularProgressIndicator());
  } else {
    // Display course grid when data is not loading
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Adjust number of columns as needed
        childAspectRatio: 1.5,
      ),
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      itemCount: widget.viewModel.courses.length,
      itemBuilder: (context, index) {
        var course = widget.viewModel.courses[index];
        return Material(child:
        InkWell(onTap: () {
          Navigator.of(context).pushNamed("${LessonView.screen}/123");
        },child: Container(child: CourseItem(title: course.title, description: course.description))));
      },
    );
  }
}
}

class CourseItem extends StatelessWidget {
  final String title;
  final String description;

  CourseItem({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

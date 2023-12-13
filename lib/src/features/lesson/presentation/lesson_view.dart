import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ravi/src/common/ui/app_bar_widget.dart';
import '../../../common/ui/code_widget.dart';
import '../domain/lesson_use_case.dart';
import 'lesson_view_model.dart';

typedef OnSublessonTap = void Function(SubLesson sublesson);

class SubLesson {
  String title;
  String taskDescription;
  String? codeTask;
  String? placeholder;
  bool isCodingTask;
  bool isEnabled;
  bool isSelected;
  bool isCompleted;

  SubLesson(
      {required this.title,
      required this.taskDescription,
      this.codeTask,
      this.placeholder,
      required this.isCodingTask,
      required this.isEnabled,
      this.isSelected = false,
      this.isCompleted = false
      });
}

class Lesson {
  String title;
  List<SubLesson> sublessons;

  Lesson({required this.title, required this.sublessons});
}

// Это CourceView, надо переименовать
class LessonView extends StatefulWidget {
  final String courceId;
  final LessonViewModel viewModel = LessonViewModel(LessonUseCase());

  static const String screen = "/cource";

  LessonView({Key? key, required this.courceId}) : super(key: key);

  @override
  _LessonView createState() => _LessonView();
}

class _LessonView extends State<LessonView> {
  List<Lesson> lessons = [];
  SubLesson? subLesson;

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_onViewModelChanged);
    widget.viewModel.fetchLessons(widget.courceId);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    // Called whenever the view model calls `notifyListeners`.
    setState(() {});
    lessons = widget.viewModel.lessons ?? [];
    subLesson = widget.viewModel.selectedSublesson;
  }

  @override
  Widget build(BuildContext context) {

    if (lessons.isEmpty && subLesson == null) {
      // Display loading indicator when data is being loaded
      return
        Scaffold(
          appBar: FMAppBarWidget.showLogin(),
          body: const Center(child: CircularProgressIndicator())
        );
    } else {
      return
        Scaffold(
            appBar: FMAppBarWidget.showLogin(),
            body: Row(
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: MenuSection(lessons: lessons, onSublessonTap: (sublesson) {
                    widget.viewModel.onSubLessonTap(sublesson);
                  }),
                ),
                Expanded(
                  child: MainContentSection(sublesson: subLesson!),
                ),
              ],
            )
        );
    }
  }
}

class MenuSection extends StatelessWidget {
  List<Lesson> lessons;
  final OnSublessonTap onSublessonTap;

  MenuSection({required this.lessons, required this.onSublessonTap});

  @override
  Widget build(BuildContext context) {
    // Example data for menu
    List<Widget> menuItems = [];

    for (var lesson in lessons) {
      // Add main lesson
      menuItems.add(ListTile(title: Text(lesson.title, style: TextStyle(color: Color.fromRGBO(238, 238, 238, 1)))));

      // Add sub-lessons directly under each main lesson
      for (var sublesson in lesson.sublessons) {
        menuItems.add(Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: SubLessonListTile(sublesson: sublesson, onTap: onSublessonTap),
        ));
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
      body: ListView(
      children: menuItems,
    ));
  }
}

class MainContentSection extends StatelessWidget {

  SubLesson sublesson;

  MainContentSection({required this.sublesson});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20), child:
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            sublesson.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          MarkdownBody(
            key: const Key("defaultmarkdownformatter"),
            data: sublesson.taskDescription,
            selectable: true,
            builders: {
              'code': CodeElementBuilder(),
            },
            ),
          SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Your Answer',
            ),
          ),
        ],
      )
      );
  }
}

class SubLessonListTile extends StatelessWidget {
  final SubLesson sublesson;
  final OnSublessonTap onTap;

  const SubLessonListTile({super.key, required this.sublesson, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Container container;
    if (sublesson.isSelected) { 
      container = Container(width: 4.0, height: 50.0, color: Colors.blue);
    } else if (sublesson.isCompleted) { 
      container = Container(width: 4.0, height: 30.0, color: Colors.green);
    } else {
      container = Container(width: 4.0);
    }

    return Row(
      children: [
        container,
        Expanded(
          child: ListTile(
            enabled: sublesson.isEnabled,
            selected: sublesson.isSelected,
            style: ListTileStyle.list,
            selectedColor: Color.fromARGB(81, 118, 74, 1),
            title: Text(
              sublesson.title,
              style: TextStyle(
                color: sublesson.isEnabled ? Color.fromRGBO(238, 238, 238, 1) : Color.fromRGBO(138, 138, 138, 1),
              ),
            ),
            onTap: () => onTap(sublesson),
          ),
        ),
      ],
    );
  }
}
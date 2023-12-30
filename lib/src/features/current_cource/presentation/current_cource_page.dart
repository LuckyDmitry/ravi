import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:ravi/src/common/ui/app_bar_widget.dart';
import 'package:ravi/src/common/ui/loading_view.dart';
import 'package:highlight/languages/kotlin.dart';
import '../../../common/firebase/firebase_helper.dart';
import '../../../service_locator.dart';
import '../../courses/data/course_dto.dart';
import '../../courses/data/course_repository.dart';
import 'cource_menu.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';

class CurrentCourcePage extends StatefulWidget {
  final String courceId;

  static const String screen = "/course";

  const CurrentCourcePage({Key? key, required this.courceId}) : super(key: key);

  @override
  CurrentCourcePageState createState() => CurrentCourcePageState();
}

class CurrentCourcePageState extends State<CurrentCourcePage> {
  final CoursesRepository courseRepository = services<CoursesRepository>();
  List<PagePreviewDTO> _pages = [];
  PageDTO? _page;
  String? _selectedPageId;

  bool _isMenuLoading = true;
  bool _isPageLoading = true;

  @override
  void initState() {
    super.initState();
    courseRepository.getCourceScheme(widget.courceId).then((scheme) => {
          /// Должно работать слегка иначе в будущем:
          /// Мы заходим на страницу и
          /// Если у нас есть query params blockNum & pageNum
          /// То мы запрашиваем страницу для этих парамов
          /// Если парамов нет,
          /// То запрашиваем для последней локации
          ///
          /// Так мы добьемся поведения, что url/cource/1?block=1&page=3 приведет к соттветствующей странице
          /// А url/cource/1 приведет к последней отекрытой
          loadPage(scheme.pages.first.pageId),
          setState(() {
            _pages = scheme.pages;
            _selectedPageId = scheme.pages.first.pageId;
            _isMenuLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FMAppBarWidget.showLogin(),
        body: Row(
          children: <Widget>[
            SizedBox(
                width: 250,
                child: loadingView(
                  _isMenuLoading,
                  context,
                  (context) => MenuSection(
                      pages: _pages,
                      selectedPageId: _selectedPageId ?? "",
                      onTileTap: _openPage),
                )),
            Expanded(
              child: loadingView(_isPageLoading, context,
                  (context) => MainContentSection(page: _page)),
            ),
          ],
        ));
  }

  void _openPage(String pageId) {
    _isMenuLoading = true;
    loadPage(pageId);
    setState(() {
      _selectedPageId = pageId;
      _isMenuLoading = false;
    });
  }

  void loadPage(String pageId) {
    courseRepository
        .getPage(pageId)
        .then((page) => {
              setState(() {
                _page = page;
                _isPageLoading = false;
              })
            });
  }
}

class MainContentSection extends StatelessWidget {
  final PageDTO? page;
  final controller = CodeController(
    text: '...', // Initial code
    language: kotlin,
  );

  MainContentSection({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    if (page == null) {
      const Center(
        child: Text("Null page"),
      );
    }
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  page!.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MarkdownBlock(
                    data: page!.content,
                    config: MarkdownConfig(
                        configs: [PreConfig(theme: a11yLightTheme)])),
                const SizedBox(height: 20),
                CodeTheme(
                    data: CodeThemeData(styles: monokaiSublimeTheme),
                    child: SingleChildScrollView(
                      child: CodeField(
                        controller: controller,
                        minLines: 15,
                      ),
                    )),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => {FirebaseCloudFunctions.sendCode()},
                    child: Text("Send code"))
              ],
            )));
  }
}

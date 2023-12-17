import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ravi/src/common/ui/app_bar_widget.dart';
import 'package:ravi/src/common/ui/loading_view.dart';
import '../../../common/ui/code_widget.dart';
import 'package:highlight/languages/kotlin.dart';
import '../../../service_locator.dart';
import '../../courses/data/course_dto.dart';
import '../../courses/data/course_repository.dart';
import 'cource_menu.dart';

class CurrentCourcePage extends StatefulWidget {
  final String courceId;

  static const String screen = "/cource";

  const CurrentCourcePage({Key? key, required this.courceId}) : super(key: key);

  @override
  CurrentCourcePageState createState() => CurrentCourcePageState();
}

class CurrentCourcePageState extends State<CurrentCourcePage> {
  final CoursesRepository courseRepository = services<CoursesRepository>();
  List<CourseBlockSchemeDTO> _blocks = [];
  PageDTO? _page;
  BlockAndPage? _select;

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
      loadPage(scheme.continueAt),
      setState(() {
        _blocks = scheme.blocks;
        _select = scheme.continueAt;
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
              child: loadingView(_isMenuLoading, context, (context) => MenuSection(
                  blocks: _blocks,
                  select: _select ?? BlockAndPage(blockNumber: 0, pageNumber: 0),
                  onTileTap: _openPage),
              )
            ),
            Expanded(
              child: loadingView(_isPageLoading, context,
                      (context) => MainContentSection(page: _page)),
            ),
          ],
        )
    );
  }

  void _openPage(BlockAndPage select) {
    _isMenuLoading = true;
    loadPage(select);
    setState(() {
      _select = select;
      _isMenuLoading = false;
    });
  }

  void loadPage(BlockAndPage select) {
    courseRepository.getPage(widget.courceId, select.blockNumber, select.pageNumber)
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
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MarkdownBody(
                  data: page!.content,
                  selectable: true,
                  builders: {
                    'code': CodeElementBuilder(),
                  },
                  styleSheet: MarkdownStyleSheet(
                    a: const TextStyle(color: Colors.white),
                    textScaleFactor: 1.0,
                    codeblockPadding: EdgeInsets.all(10),
                  ),
                  styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                ),
                const SizedBox(height: 20),
                CodeTheme(
                    data: CodeThemeData(styles: monokaiSublimeTheme),
                    child: SingleChildScrollView(
                      child: CodeField(
                        controller: controller,
                        minLines: 15,
                      ),
                    )),
                  ElevatedButton(onPressed: () => { 

                  }, child: Text("Send"))
              ],
            )));
  }
}
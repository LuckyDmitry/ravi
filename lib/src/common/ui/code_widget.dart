import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart'; // Choose your theme
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';

    if (element.attributes['class'] != null) {
      String langClass = element.attributes['class'] as String;
      if (langClass.startsWith('language-')) {
        language = langClass.substring(9);
      }
    }

    return Container(
      // margin: EdgeInsets.all(8), // Outer spacing
      padding: EdgeInsets.all(0.5), // Inner spacing
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Color.fromRGBO(243, 244, 246, 1), // Custom background color
        border: Border.all(
          color: Color.fromRGBO(237, 238, 242, 1), // Custom border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: HighlightView(
          element.textContent,
          language: language,
          theme: githubTheme, // Your syntax highlighting theme
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}

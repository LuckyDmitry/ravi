import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../courses/data/course_dto.dart';

class MenuSection extends StatelessWidget {
  final List<PagePreviewDTO> pages;
  final String selectedPageId;
  final OnTileTap onTileTap;

  const MenuSection(
      {super.key,
      required this.pages,
      required this.selectedPageId,
      required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    List<Widget> menuItems = [];

    // Add sub-lessons directly under each main lesson
    for (var page in pages) {
      menuItems.add(CourceSchemeListTile(
        entity: CourceSchemeEntity(
          title: page.title,
          pageId: page.pageId,
          isCompleted: false,
          isSelected: selectedPageId == page.pageId,
        ),
        onTap: onTileTap,
      ));
    }

    return Scaffold(
        backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        body: ListView(
          children: menuItems,
        ));
  }
}

class CourceSchemeEntity {
  final String title;
  final String pageId;
  final bool isCompleted;
  final bool isSelected;

  const CourceSchemeEntity(
      {required this.title,
      required this.pageId,
      required this.isCompleted,
      required this.isSelected});
}

typedef OnTileTap = void Function(String select);

class CourceSchemeListTile extends StatelessWidget {
  final CourceSchemeEntity entity;
  final OnTileTap onTap;

  const CourceSchemeListTile(
      {super.key, required this.onTap, required this.entity});

  @override
  Widget build(BuildContext context) {
    Container container;
    if (entity.isSelected) {
      container = Container(width: 4.0, height: 50.0, color: Colors.blue);
    } else if (entity.isCompleted) {
      container = Container(width: 4.0, height: 30.0, color: Colors.green);
    } else {
      container = Container(width: 4.0);
    }

    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          children: [
            container,
            Expanded(
              child: ListTile(
                selected: entity.isSelected,
                style: ListTileStyle.list,
                selectedColor: const Color.fromARGB(81, 118, 74, 1),
                title: Text(
                  entity.title,
                  style: const TextStyle(
                    color: Color.fromRGBO(238, 238, 238, 1),
                  ),
                ),
                onTap: () => {onTap(entity.pageId)},
              ),
            ),
          ],
        ));
  }
}

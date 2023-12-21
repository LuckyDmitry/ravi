import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../courses/data/course_dto.dart';

class MenuSection extends StatelessWidget {
  final List<CourseBlockSchemeDTO> blocks;
  final BlockAndPage select;
  final OnTileTap onTileTap;

  const MenuSection({super.key, required this.blocks, required this.select, required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    List<Widget> menuItems = [];

    for (var block in blocks) {
      menuItems.add(CourceSchemeListTile(
        entity: CourceSchemeEntity(
          title: block.title,
          type: BLOCK(number: block.number),
          isCompleted: block.isCompleted,
          isSelected: select.blockNumber == block.number
              && select.pageNumber == 0,
        ),
        onTap: onTileTap,
      ));

      // Add sub-lessons directly under each main lesson
      for (var page in block.pages) {
        menuItems.add(
          CourceSchemeListTile(
              entity: CourceSchemeEntity(
                  title: page.title,
                  type: PAGE(blockNumber: block.number, number: page.number),
                  isCompleted: page.completed,
                  isSelected: select.blockNumber == block.number
                      && select.pageNumber == page.number,
              ),
              onTap: onTileTap,
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

class CourceSchemeEntity {
  final String title;
  final CourceSchemeEntityType type;
  final bool isCompleted;
  final bool isSelected;

  const CourceSchemeEntity({required this.title, required this.type, required this.isCompleted, required this.isSelected});
}

typedef OnTileTap = void Function(BlockAndPage select);

abstract class CourceSchemeEntityType {}
class BLOCK implements CourceSchemeEntityType {
  final int number;
  const BLOCK({required this.number});
}
class PAGE implements CourceSchemeEntityType{
  final int number;
  final int blockNumber;
  const PAGE({required this.number, required this.blockNumber});
}

class CourceSchemeListTile extends StatelessWidget {
  final CourceSchemeEntity entity;
  final OnTileTap onTap;

  const CourceSchemeListTile({super.key, required this.onTap, required this.entity});

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
                onTap: () => {
                  if (entity.type is BLOCK) {
                    onTap(BlockAndPage(
                        blockNumber: (entity.type as BLOCK).number,
                        pageNumber: 0))
                  } else {
                    onTap(BlockAndPage(
                        blockNumber: (entity.type as PAGE).blockNumber,
                        pageNumber: (entity.type as PAGE).number))
                  }
                },
              ),
            ),
          ],
        ));
  }
}
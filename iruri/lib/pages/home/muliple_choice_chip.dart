import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';

class MultiChoiceChip extends StatefulWidget {
  /*
   *  choiceChipType = 0 → applicant position
   *                 = 1 → genre  
   */
  final int choiceChipType;
  final Map<String, Map<String, bool>> typeMap;
  final Function(Map<String, Map<String, bool>>) onSelectionChanged;

  MultiChoiceChip({this.choiceChipType, this.typeMap, this.onSelectionChanged});

  @override
  _MultiChoiceChipState createState() => _MultiChoiceChipState();
}

class _MultiChoiceChipState extends State<MultiChoiceChip> {
  Map<String, Map<String, bool>> map;

  Map<String, Color> applicantColorMap = {
    'write_main': tagWrite,
    'write_conti': tagWrite,
    'draw_main': tagDraw,
    'draw_conti': tagConti,
    'draw_dessin': tagDessin,
    'draw_line': tagDraw,
    'draw_char': tagCharacter,
    'draw_color': tagPaint,
    'draw_after': tagDraw
  };

  Map<String, Color> genreColorMap = {
    'thriller': genreThriller,
    'drama': genreDrama,
    'fantasy': genreFantasy,
    'action': genreAction,
    'muhyup': genreMuhyup,
    'romance': genreRomance,
    'teen': genreTeen,
    'comic': genreComic,
    'daily': genreDaily,
    'sports': genreSports,
    'costume': genreCostumeDrama,
    'horror': genreHorror,
    'sf': genreSF,
  };

  void changeInnerMap(String outerKey, String innerKey, bool selected) {
    map[outerKey][innerKey] = selected;
  }

  @override
  void initState() {
    super.initState();
    map = widget.typeMap;
  }

  _buildChoices() {
    List<Widget> choices = [];
    widget.typeMap.forEach((key, val) {
      choices.add(Container(
        padding: paddingH6V4,
        child: ChoiceChip(
          backgroundColor: widget.choiceChipType == 0
              ? applicantColorMap[val.keys.first]
              : genreColorMap[val.keys.first],
          label: Text(key),
          selected: val.values.first,
          onSelected: (selected) {
            setState(() {
              changeInnerMap(key, val.keys.first, selected);
              widget.onSelectionChanged(map);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoices(),
    );
  }
}

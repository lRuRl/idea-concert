import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/model/user.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';
import 'package:iruri/pages/state/state_utils.dart';
import 'package:iruri/util/data_user.dart';
// provider
import 'package:provider/provider.dart';
import 'package:iruri/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// light gray 색 구분선
const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);

class HomeArticle extends StatelessWidget {
  // data input
  final Article data;
  const HomeArticle({this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // provider
    final routerReader = context.read<CustomRouter>();
    final routerWatcher = context.watch<CustomRouter>();

    return InkWell(
        onTap: () => routerReader.navigateTo(
            routerWatcher.currentPage, '/home/projectdetail',
            data: data),
        child: Container(
          width: size.width * 0.9,
          height: size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // 8px
            border: Border.all(color: lightWhite, width: 2.0),
          ),
          margin: marginH20V10,
          padding: paddingH10V10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Thumbnail | CONTENTS
            children: <Widget>[
              Expanded(
                flex: 4,
                child: data.imagePath != null
                    ? ImageWrapper(image: data.image)
                    : Image.asset('assets/default.png'),
              ),
              SizedBox(width: 20),
              // CONTENTS
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // title and iconbutton - spacebetween
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    // title
                                    flex: 9,
                                    child: Text(data.detail.content.title,
                                        style: articleTitleTextStyle)),
                                Expanded(
                                    flex: 1,
                                    child: Icon(FeatherIcons.chevronRight))
                              ],
                            ))),
                    // tags -start
                    Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 4 / 2,
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 5),
                              itemCount: data.detail.content.tags.length,
                              itemBuilder: (context, index) => TagWrapper(
                                    tag: data.detail.content.tags[index],
                                  ))),
                    ),
                    // genres - start
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            data.detail.content.genres
                                .toString()
                                .substring(
                                    1,
                                    data.detail.content.genres
                                            .toString()
                                            .length -
                                        1)
                                .replaceAll(', ', ' · '),
                            style: articleTagTextStyle),
                      ),
                    ),
                    // writer - start
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(data.detail.writer.length > 10 
                              ? data.detail.writer.substring(0, 10)
                              : data.detail.writer,
                                  style: articleWriterTextStyle),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Text>[
                                    Text('마감일 ', style: articleWriterTextStyle),
                                    Text(
                                        'D-' +
                                            DateTime.parse(data.detail.dueDate)
                                                .difference(DateTime.now())
                                                .inDays
                                                .toString(),
                                        style: articleDuedateTextStyle)
                                  ])
                            ],
                          )),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

/**
 *  onPressed => required
 *  tag => only String !!!
 */
// ignore: must_be_immutable
class TagWrapper extends StatelessWidget {
  final onPressed;
  final String tag;

  TagWrapper({this.onPressed, this.tag});

  // tag color mapper
  Map<String, Color> colorMapper = {
    '메인글': tagWrite,
    '채색': tagPaint,
    '선화': themeLightOrange,
    '그림콘티': tagConti,
    '캐릭터': tagCharacter,
    '메인그림': tagDraw,
    '데생': tagDessin,
    '후보정': themeBlue,
    '승인대기': tagApproval_WAIT,
    '승인수락': tagApproval_YES,
    '승인거절': tagApproval_NO,
  };

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // primary: colorMapper[tag],
          backgroundColor: colorMapper[tag] != null
              ? colorMapper[tag]
              : themeRed.withOpacity(0.2),
          alignment: Alignment.center,
          elevation: 0.0, // no shadow

          padding: paddingH2V1),
      child: Text(tag, style: articleTagTextStyle),
    );
  }
}

// get image from network
class ImageWrapper extends StatefulWidget {
  final String image;
  ImageWrapper({this.image});
  @override
  _ImageWrapperState createState() => _ImageWrapperState();
}

class _ImageWrapperState extends State<ImageWrapper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        child: Image.memory(
          base64Decode(widget.image),
          height: size.width * 0.3,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.error_outline_rounded, size: 24, color: themeGrayText),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Position_Small extends StatelessWidget {
  final List<String> data = ["채색", "콘티", "선화", "캐릭터"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4) {
      bottomMargin = 2;
    } else {
      bottomMargin = 5;
    }
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        // padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        alignment: Alignment.topCenter,
        width: size.width * 0.35,
        // height: size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //   width: 1,
          //   color: themeLightGrayOpacity20,
          // ),
          // color: themeLightGrayOpacity20,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3.5 / 1.5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3),
                        itemCount: data.length,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () =>
                                  print("tag pressed"), //_showDialog(context),
                              tag: data[index],
                            ))),
              )
            ]));
  }
}

class PositionSmallLinear extends StatelessWidget {
  // dynamic data
  final List<String> data;
  PositionSmallLinear({this.data});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // physics: AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.3,
            crossAxisCount: data.length <= 3 ? data.length : 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 5),
        itemCount: data.length > 3 ? 3 : data.length,
        itemBuilder: (context, index) => TagWrapper(
              //_showDialog(context),
              tag: data[index],
            ));
  }
}

class PositionChange extends StatefulWidget {
  @override
  _PositionChangeState createState() => _PositionChangeState();
}

class _PositionChangeState extends State<PositionChange> {
  Map<String, Map<String, dynamic>> _formTextField;

  // save data
  Map<String, Map<String, bool>> applicantType = {
    '메인글': {'write_main': false},
    '글콘티': {'write_conti': false},
    '메인그림': {'draw_main': false},
    '그림콘티': {'draw_conti': false},
    '뎃셍': {'draw_dessin': false},
    '선화': {'draw_line': false},
    '캐릭터': {'draw_char': false},
    '채색': {'draw_color': false},
    '후보정': {'draw_after': false}
  };

  String location;
  //  style
  var formTextStyle = notoSansTextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, textColor: greyText);

  @override
  void initState() {
    super.initState();
    _formTextField = new Map<String, Map<String, dynamic>>.from({
      "applicants": {"controller": null, "state": 0},
    }); // data
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: paddingH20V5,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                width: 3,
                color: _formTextField["applicants"]["state"] == 0
                    ? Colors.transparent
                    : _formTextField["applicants"]["state"] == 1
                        ? onSuccess
                        : onError)),
        child: Column(children: <Widget>[
          MultiChoiceChip(
              choiceChipType: 0,
              typeMap: applicantType,
              onSelectionChanged: applicantTypeChanged),
          ElevatedButton(
              child: new Text("저장"),
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                onPrimary: Colors.white,
              ))
        ]));
  }

  void applicantTypeChanged(Map<String, Map<String, bool>> map) {
    setState(() {
      applicantType = map;
    });
  }
}

// ignore: must_be_immutable
class ApprovalState extends StatelessWidget {
  int stateIndex = 0;
  ApprovalState({this.stateIndex});
  final List<String> data = ["승인대기", "승인수락", "승인거절"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        // alignment: Alignment.topCenter,
        width: size.width * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: lightWhite),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //flex: 5,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 1.5,
                            crossAxisCount: 1,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0),
                        itemCount: 1,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () => print('tag pressed'),
                              tag: data[this.stateIndex],
                            ))),
              )
            ]));
  }
}

class AgreeContract extends StatefulWidget {
  final String pdfPath;
  final int index;
  AgreeContract({this.pdfPath, this.index});
  @override
  _AgreeContractState createState() => _AgreeContractState();
}

class _AgreeContractState extends State<AgreeContract> {
  bool _value = false;
  int index;
  bool _isLoading = true;

  String pdfPath;
  @override
  void initState() {
    super.initState();
    index = widget.index;
    pdfPath = widget.pdfPath;

    createFileOfPdfUrl().then((f) {
      setState(() {
        pdfPath = f.path;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width * 1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("계약서 조항 ($index)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _value = !_value;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: themeLightOrange),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: _value
                                ? Icon(
                                    Icons.check,
                                    size: 18.0,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 18.0,
                                    color: themeLightOrange,
                                  ),
                          ),
                        ),
                      ),
                    ]))
          ])),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.4,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFView(
                  filePath: pdfPath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  fitPolicy: FitPolicy.BOTH,
                ))
    ]);
  }
}

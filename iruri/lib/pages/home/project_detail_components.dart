import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:iruri/pages/state/state_utils.dart';

Widget thumbnail(BuildContext context, Article data) {
  return Image.memory(
    base64Decode(data.image),
    alignment: Alignment.center,
    errorBuilder: (context, error, stackTrace) =>
        Icon(Icons.error_outline_rounded, size: 24, color: themeGrayText),
    fit: BoxFit.cover,
  );
}

Widget noticeDetail(BuildContext context, Article data) {
  return Container(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 10,
            children: [
              Text(data.detail.content.title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 2 / 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10),
                itemCount: data.detail.content.tags.length,
                itemBuilder: (context, index) =>
                    TagWrapper(tag: data.detail.content.tags[index]),
              )
            ],
          ),
          // Position_Small_Linear(),
          Row(
            children: [
              Text(data.detail.writer + " | ",
                  style: TextStyle(
                      color: Color.fromRGBO(0x00, 0x00, 0x00, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 11)),
              Text(data.detail.location,
                  style: TextStyle(
                      color: Color.fromRGBO(0x77, 0x77, 0x77, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 11)),
            ],
          ),
          Text(data.detail.content.genres.join(' · '),
              style: TextStyle(
                  color: Color.fromRGBO(0x77, 0x77, 0x77, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 11)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0xff, 0xff, 0xff, 1),
                  border:
                      Border.all(color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.heart,
                      size: 14,
                    ),
                    Text(
                      " 30 ",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: <Text>[
                          Text('마감일 ', style: articleWriterTextStyle),
                          Text(
                              'D-DAY ' +
                                  DateTime.parse(data.detail.dueDate)
                                      .difference(DateTime.now())
                                      .inDays
                                      .toString(),
                              style: articleDuedateTextStyle)
                        ]),
                      ],
                    )),
              )
            ],
          )
        ]),
  );
}

Widget projectCalendar(BuildContext context, Article data) {
  final begin = DateTime.parse(data.detail.period.from);
  final end = DateTime.parse(data.detail.period.to);

  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(
      flex: 2,
      child: Text("모집 조건",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.left),
    ),
    Expanded(
        flex: 5,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.edit,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      "전자 서명",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.penTool,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      // "6개월 ~ 1년",
                      (end.difference(begin).inDays ~/ 30).toString() + ' 개월',
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.calendar,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      "월 ~ 금",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FeatherIcons.clock,
                      size: 20,
                      color: Color.fromRGBO(0x82, 0x82, 0x82, 1),
                    ),
                    Text(
                      "탄력 근무제",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color.fromRGBO(0x82, 0x82, 0x82, 1)),
                    ),
                  ],
                ),
              ],
            )))
  ]));
}

Widget projectDetailContent(BuildContext context, Article data) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("프로젝트 상세 내용",
        style: TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.left),
    Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(data.detail.content.desc))
  ]));
}

Widget applyButton(BuildContext context, String mode, Article data) {
  return TextButton(
      onPressed: () {
        showMaterialModalBottomSheet(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          context: context,
          builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: SelectBoxApply(
                data: data,
              )),
        );
      },
      child: Text("지원하기", style: buttonWhiteTextStyle),
      style: TextButton.styleFrom(
          padding: paddingH20V5,
          backgroundColor: primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));
}

Widget scrapButton() {
  return TextButton(
      onPressed: () {},
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              FeatherIcons.bookmark,
              size: 20,
              color: primary,
            ),
            Text("스크랩",
                style: notoSansTextStyle(
                    fontSize: 16,
                    textColor: primary,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        padding: paddingH6V4,
        primary: Colors.white,
        side: BorderSide(color: primary, width: 0.8),
      ));
}

Widget customBox(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;

  return Container(
    width: size.width * 0.3,
    height: size.height * 0.08,
    decoration: BoxDecoration(
      color: Color.fromRGBO(196, 196, 196, 0.13),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Center(child: Text(text, textAlign: TextAlign.center)),
  );
}

showMyDialog(BuildContext context, String str1, String str2) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        elevation: 5.0,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height / 4,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(FeatherIcons.checkCircle,
                      size: 45, color: Color.fromRGBO(0xFF, 0x94, 0x3a, 1)),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        str1,
                        style: TextStyle(
                            color: Color.fromRGBO(0x16, 0x16, 0x16, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Text(""),
                      Text(
                        str2,
                        style: TextStyle(
                            color: Color.fromRGBO(0x67, 0x67, 0x67, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("확인",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 4),

                          //fixedSize: Size(90, 30),
                          primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                          onPrimary: Colors.white,
                        ))),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      );
    },
  );
}

showcontractDialog(BuildContext context) {
  ContractContentElement contentState = new ContractContentElement();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        elevation: 5.0,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.26,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [contentState],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("취소",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 0),

                              //fixedSize: Size(90, 30),
                              primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                              onPrimary: Colors.white,
                            )),
                        SizedBox(width: 8),
                        ElevatedButton(
                            onPressed: () {
                              bool noneCheck = false;
                              List<bool> result = contentState.getCheckState();

                              for (int i = 0; i < 4; i++) {
                                if (result[i] == false) {
                                  noneCheck = true;
                                  break;
                                }
                              }
                              noneCheck == true
                                  ? customDialog(context, '동의하지 않은 항목이 존재합니다.')
                                  : showMyDialog(context, '저장이 완료되었습니다.', '')
                                      .then((value) {
                                      Navigator.pop(context);
                                    });
                              // Navigator.pop(context);
                            },
                            child: Text("동의하고 서명 완료",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 0),

                              //fixedSize: Size(90, 30),
                              primary: Color.fromRGBO(0x1b, 0x30, 0x59, 1),
                              onPrimary: Colors.white,
                            ))
                      ],
                    ))
              ],
            )),
      );
    },
  );
}

showDetailSignElementDialog(BuildContext context) {
  ScrollController scrollController = new ScrollController();
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          backgroundColor: Colors.white,
          elevation: 2.0,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: MediaQuery.of(context).size.height * 0.8,
              // padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 13,
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: SingleChildScrollView(
                                controller: scrollController,
                                child: Text(
                                    '제1조(목적) 이 법은 전자문서의 안전성과 신뢰성을 확보하고 그 이용을 활성화하기 위하여 전자서명에 관한 기본적인 사항을 정함으로써 국가와 사회의 정보화를 촉진하고 국민생활의 편익을 증진함을 목적으로 한다. \n\n제2조(정의) 이 법에서 사용하는 용어의 뜻은 다음과 같다.\n1. “전자문서”란 정보처리시스템에 의하여 전자적 형태로 작성되어 송신 또는 수신되거나 저장된 정보를 말한다.\n2. “전자서명”이란 다음 각 목의 사항을 나타내는 데 이용하기 위하여 전자문서에 첨부되거나 논리적으로 결합된 전자적 형태의 정보를 말한다.\n가. 서명자의 신원나. 서명자가 해당 전자문서에 서명하였다는 사실\n3. “전자서명생성정보”란 전자서명을 생성하기 위하여 이용하는 전자적 정보를 말한다.\n4. “전자서명수단”이란 전자서명을 하기 위하여 이용하는 전자적 수단을 말한다.\n5. “전자서명인증”이란 전자서명생성정보가 가입자에게 유일하게 속한다는 사실을 확인하고 이를 증명하는 행위를 말한다.\n6. “인증서”란 전자서명생성정보가 가입자에게 유일하게 속한다는 사실 등을 확인하고 이를 증명하는 전자적 정보를 말한다.\n7. “전자서명인증업무”란 전자서명인증, 전자서명인증 관련 기록의 관리 등 전자서명인증서비스를 제공하는 업무를 말한다.\n8. “전자서명인증사업자”란 전자서명인증업무를 하는 자를 말한다.\n9. “가입자”란 전자서명생성정보에 대하여 전자서명인증사업자로부터 전자서명인증을 받은 자를 말한다.\n10. “이용자”란 전자서명인증사업자가 제공하는 전자서명인증서비스를 이용하는 자를 말한다.\n\n제3조(전자서명의 효력) ① 전자서명은 전자적 형태라는 이유만으로 서명, 서명날인 또는 기명날인으로서의 효력이 부인되지 아니한다.\n② 법령의 규정 또는 당사자 간의 약정에 따라 서명, 서명날인 또는 기명날인의 방식으로 전자서명을 선택한 경우 그 전자서명은 서명, 서명날인 또는 기명날인으로서의 효력을 가진다.\n\n제19조(전자서명생성정보의 보호 등) ① 누구든지 타인의 전자서명생성정보를 도용하거나 누설해서는 아니 된다.\n② 누구든지 운영기준 준수사실의 인정을 받은 전자서명인증사업자가 발급하는 인증서와 관련하여 다음 각 호에 해당하는 행위를 하여서는 아니 된다.\n1. 거짓이나 그 밖의 부정한 방법으로 타인의 명의로 인증서를 발급받거나 발급받을 수 있도록 하는 행위\n2. 부정하게 행사하게 할 목적으로 인증서를 타인에게 양도 또는 대여하거나, 부정하게 행사할 목적으로 인증서를 타인으로부터 양도 또는 대여받는 행위\n\n제20조(손해배상책임) ① 운영기준 준수사실의 인정을 받은 전자서명인증사업자가 전자서명인증업무의 수행과 관련하여 가입자 또는 이용자에게 손해를 입힌 경우에는 그 손해를 배상하여야 한다. 다만, 전자서명인증사업자가 고의 또는 과실이 없음을 입증하면 그 배상책임이 면제된다.\n② 운영기준 준수사실의 인정을 받은 전자서명인증사업자는 제1항에 따른 손해를 배상하기 위하여 대통령령으로 정하는 바에 따라 보험에 가입하여야 한다.\n\n제24조(벌칙) ① 다음 각 호의 어느 하나에 해당하는 자는 3년 이하의 징역 또는 3천만원 이하의 벌금에 처한다.\n1. 제19조제1항을 위반하여 타인의 전자서명생성정보를 도용하거나 누설한 자\n2. 제19조제2항제1호를 위반하여 거짓이나 그 밖의 부정한 방법으로 타인의 명의로 인증서를 발급받거나 발급받을 수 있도록 한 자\n② 제19조제2항제2호를 위반하여 부정하게 행사하게 할 목적으로 인증서를 타인에게 양도 또는 대여하거나, 부정하게 행사할 목적으로 인증서를 타인으로부터 양도 또는 대여받은 자는 1년 이하의 징역 또는 1천만원 이하의 벌금에 처한다.\n\n제25조(양벌규정) 법인의 대표자나 법인 또는 개인의 대리인, 사용인, 그 밖의 종업원이 그 법인 또는 개인의 업무에 관하여 제24조의 위반행위를 한 경우에는 행위자를 벌하는 외에 그 법인 또는 개인에게도 해당 조문의 벌금형을 과(科)한다. 다만, 법인 또는 개인이 그 위반행위를 방지하기 위하여 해당 업무에 관하여 상당한 주의와 감독을 게을리하지 아니한 경우에는 그러하지 아니하다.',
                                    style: notoSansTextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        textColor: Color.fromRGBO(
                                            0x4f, 0x4f, 0x4f, 1)))))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.98,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0xf2, 0xc9, 0x4c, 1),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16)),
                            ),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                    child: Text("동의",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        )))))),
                  ])));
    },
  );
}

customDialog(BuildContext context, String str1) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: Colors.white,
        elevation: 5.0,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height / 4.8,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(FeatherIcons.xCircle,
                      size: 60, color: Color.fromRGBO(0xFF, 0x94, 0x3a, 1)),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        str1,
                        style: TextStyle(
                            color: Color.fromRGBO(0x16, 0x16, 0x16, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("확인",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 2),

                          //fixedSize: Size(90, 30),
                          primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                          onPrimary: Colors.white,
                        )))
              ],
            )),
      );
    },
  );
}

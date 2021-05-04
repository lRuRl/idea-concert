import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iruri/components/input_decoration.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/text_form_field.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';
import 'dart:io' show Platform;

class PostArticle extends StatefulWidget {
  /*
   *  Auth -> 사용자 정보를 받아와야 할듯 
   */
  PostArticle({Key key}) : super(key: key);

  @override
  _PostArticleState createState() => _PostArticleState();
}

class _PostArticleState extends State<PostArticle> {
  // form key
  final _formKey = GlobalKey<FormBuilderState>();

  // controller
  ScrollController controller;

  // upload Data
  Article uploadArticle;

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

  Map<String, Map<String, bool>> genreType = {
    '스릴러': {'thriller': false},
    '드라마': {'drama': false},
    '판타지': {'fantasy': false},
    '액션': {'action': false},
    '무협': {'muhyup': false},
    '로맨스': {'romance': false},
    '학원': {'teen': false},
    '코믹': {'comic': false},
    '일상': {'daily': false},
    '스포츠': {'sports': false},
    '시대극': {'costume': false},
    '공포': {'horror': false},
    'SF': {'sf': false}
  };

  void applicantTypeChanged(Map<String, Map<String, bool>> map) {
    setState(() {
      applicantType = map;
    });
  }

  void genreTypeChanged(Map<String, Map<String, bool>> map) {
    setState(() {
      genreType = map;
    });
  }

  bool validateMultiChoices() {
    int applicant = 0, genre = 0;
    applicantType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) applicant++;
    });
    genreType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) genre++;
    });
    return applicant > 0 && genre > 0 ? true : false;
  }

  void validateWholeForm() {
    if (_formKey.currentState.saveAndValidate() && validateMultiChoices()) {
      print(_formKey.currentState.value);
    } else {
      print(_formKey.currentState.value);
      print('validation failed');
    }
  }
  
  @override
  void initState() {
    super.initState();
    // controller
    controller = new ScrollController();
    // model
    uploadArticle = new Article();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // backbutton
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: themeGrayText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('게시글 작성', style: appBarTitleTextStyle),
        elevation: 0.5,
      ),
      body: GestureDetector(
          // used for keyboard dismiss
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            padding: paddingH20V20,
            color: Colors.white,
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: <Widget>[
                  FormBuilder(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // thumbnail  - img
                            SizedBox(
                              height: 200,
                              child: Text('image picker'),
                            ),
                            // project name
                            FormBuilderTextField(
                              name: 'introduction',
                              decoration: borderTextInputBox(
                                  onPressed: () =>
                                      _formKey.currentState.reset(),
                                  icon: Icon(Icons.title_rounded,
                                      size: 24, color: themeGrayText),
                                  labelText: '프로젝트 제목',
                                  hintText: '20자 이내로 제목을 입력해주세요',
                                  validate: 0
                                          ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                // 20자 최대
                                FormBuilderValidators.maxLength(context, 20)
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // period - date picker
                            FormBuilderDateTimePicker(
                              name: 'dueDate',
                              initialValue: DateTime.now(),
                              inputType: InputType.both,
                              decoration: textFieldStyle(
                                  icon: Icon(Icons.date_range_rounded,
                                      size: 24, color: themeGrayText),
                                  labelText: '프로젝트 공고 마감일'),
                              // Platform
                              // pickerType: Platform.isIOS
                              //     ? PickerType.cupertino
                              //     : PickerType.material,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              //locale: Locale.fromSubtags(languageCode: 'fr'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // genre - multi choice
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.list_rounded,
                                        size: 24, color: themeGrayText),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "프로젝트 장르 선택",
                                      style: bodyTextStyle,
                                    )
                                  ],
                                ),
                                MultiChoiceChip(
                                    choiceChipType: 1,
                                    typeMap: genreType,
                                    onSelectionChanged: genreTypeChanged),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // desc - text
                            FormBuilderTextField(
                              name: 'desc',
                              decoration: textFieldStyle(
                                  icon: Icon(Icons.description_rounded,
                                      size: 24, color: themeGrayText),
                                  labelText: '프로젝트 설명'),
                              maxLines: null,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // applicant - multi choice
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.tag,
                                        size: 24, color: themeGrayText),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "프로젝트 지원자 선택",
                                      style: bodyTextStyle,
                                    )
                                  ],
                                ),
                                MultiChoiceChip(
                                    choiceChipType: 0,
                                    typeMap: applicantType,
                                    onSelectionChanged: applicantTypeChanged),
                              ],
                            ),
                            // prefer - text
                            FormBuilderTextField(
                              name: 'prefer',
                              decoration: textFieldStyle(
                                  icon: Icon(Icons.thumb_up,
                                      size: 24, color: themeGrayText),
                                  labelText: '프로젝트 우대사항'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                // 20자 최대
                                FormBuilderValidators.maxLength(context, 20)
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // location - scroll
                            // FormBuilderDropdown(
                            //   name: 'location',
                            //   items: <DropdownMenuItem>[
                            //     DropdownMenuItem(child: ),
                            //     '서울',
                            //     '인천',
                            //     '부산',
                            //     '대구',
                            //     '광주',
                            //     '대전',
                            //     '울산',
                            //     '제주',
                            //     '경기',
                            //     '강원',
                            //     '충북',
                            //     '충남',
                            //     '전북',
                            //     '전남',
                            //     '경북',
                            //     '경남'
                            //   ],
                            //   decoration: textFieldStyle(
                            //       icon: Icon(Icons.place_rounded,
                            //           size: 24, color: themeGrayText),
                            //       labelText: '근무지'),
                            //   showAsSuffixIcons: true,
                            //   searchBoxDecoration: textFieldStyle(),
                            //   autoFocusSearchBox: true,
                            //   validator: FormBuilderValidators.compose([
                            //     FormBuilderValidators.required(context),
                            //   ]),
                            // ),
                          ])),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: themeLightOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: paddingH20V5),
                      onPressed: () => validateWholeForm(),
                      child: const Text(
                        '지원하기',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}

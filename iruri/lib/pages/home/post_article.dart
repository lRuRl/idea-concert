import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iruri/components/input_decoration.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/text_form_field.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';
import 'dart:io';

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
  File _thumbnail;
  /**
   *  key의 currentState를 이용해 보려고 하였는데 방법을 찾지못해
   *  TextEditingController로 대체합니다.
   *  - 2021/05/04 @seunghwanly
   */
  /*
  *  USAGE EXAMPLE >> 
  *      _titleField.keys.first : TextEditingController
  *      _titleField.values.first : validation
  *   STATUS CODE :
  *  -1 : error state ❌
  *  0 : normal state 
  *  1 : success state ✅
  */
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

  List<String> locations = [
    '서울',
    '인천',
    '경기',
    '강원',
    '대전',
    '충북',
    '충남',
    '광주',
    '전북',
    '전남',
    '대구',
    '경북',
    '울산',
    '경남',
    '부산',
    '제주'
  ];

  String location;

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

  bool validateGenre() {
    int genre = 0;
    genreType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) genre++;
    });
    return genre > 0 ? true : false;
  }

  bool validateApplicant() {
    int applicant = 0;
    applicantType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) applicant++;
    });
    return applicant > 0 ? true : false;
  }

  void setValidationState(String key, int state) {
    setState(() {
      _formTextField[key]["state"] = state;
    });
    // print("$key state is set to $state");
  }

  // ignore: slash_for_doc_comments
  /**
   *  전체 Form을 올바르게 입력했는지 확인
   *  전체 올바르게 입력 완료한 경우, 모든 state는 +1
   *  올바르게 입력 안된 경우에는 state -1
   *  state 같은 경우, 입력하는 칸에만 해당
   */
  void validateWholeForm() {
    if (_formKey.currentState.saveAndValidate() &&
        validateApplicant() &&
        validateGenre()) {
      // set states to +1
      _formKey.currentState.value.forEach((key, value) {
        setValidationState(key, 1);
      });
      setValidationState('applicant', 1);
      setValidationState("genre", 1);

      print(_formKey.currentState.value);
    } else {
      // FAIL TO VALIDATE
      // check current form values
      // set states to -1
      _formTextField.entries.forEach((element) {
        if (element.value.values.first.runtimeType == TextEditingController) {
          int length = element.value.values.first.text.length;
          if (length == 0)
            setValidationState(element.key, -1);
          else
            setValidationState(element.key, 1);
        }
      });
      // check multiChoices
      if (!validateApplicant()) setValidationState("applicant", -1);
      if (!validateGenre()) setValidationState("genre", -1);
      print("validation failed");
    }
  }

  void setItemFromDropDown(String item) => location = item;

  // thumbnail upload button pressed
  void onThumbnailUploadPressed() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _thumbnail = File(pickedFile.path);
      } else {
        print("no image selected");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // controller
    controller = new ScrollController();
    // data
    _formTextField = new Map<String, Map<String, dynamic>>.from({
      "title": {"controller": TextEditingController(), "state": 0},
      "dueDate": {"controller": TextEditingController(), "state": 0},
      "period": {"controller": TextEditingController(), "state": 0},
      "desc": {"controller": TextEditingController(), "state": 0},
      "prefer": {"controller": TextEditingController(), "state": 0},
      // for multi choices
      "applicant": {"controller": null, "state": 0},
      "genre": {"controller": null, "state": 0},
      // dropdown
      "location": {"controller": null, "state": 0}
    });
  }

  @override
  Widget build(BuildContext context) {
    // size
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // backbutton
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, color: themeGrayText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("게시글 작성", style: appBarTitleTextStyle),
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
                            SizedBox(height: 20),
                            // thumbnail  - img
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: <Widget>[
                                Container(
                                  width: size.width,
                                  height: size.height * 0.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: subLine),
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: _thumbnail != null
                                              ? FileImage(_thumbnail)
                                              : AssetImage(
                                                  "assets/default.png"),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  margin: marginH20V10,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 16.0,
                                          primary: themeOrange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8) // 8px
                                              )),
                                      onPressed: () =>
                                          onThumbnailUploadPressed(),
                                      child: Text("수정",
                                          style: notoSansTextStyle(
                                              fontSize: 16,
                                              textColor: Colors.white,
                                              fontWeight: FontWeight.w600))),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // project name
                            FormBuilderTextField(
                              controller: _formTextField["title"]["controller"],
                              name: "title",
                              decoration: borderTextInputBox(
                                  displaySuffixIcon: true,
                                  onPressed: () => _formTextField["title"]
                                          ["controller"]
                                      .text = "",
                                  icon: Icon(FeatherIcons.tag,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 제목",
                                  hintText: "20자 이내로 제목을 입력해주세요",
                                  validate: _formTextField["title"]["state"]),
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
                              controller: _formTextField["dueDate"]
                                  ["controller"],
                              name: "dueDate",
                              inputType: InputType.both,
                              decoration: borderTextInputBox(
                                  onPressed: () => _formTextField["dueDate"]
                                          ["controller"]
                                      .text = "",
                                  displaySuffixIcon: true,
                                  icon: Icon(FeatherIcons.calendar,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 공고 마감일",
                                  validate: _formTextField["dueDate"]["state"]),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              //locale: Locale.fromSubtags(languageCode: "fr"),
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
                                    Icon(FeatherIcons.hash,
                                        size: 24, color: themeGrayText),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("프로젝트 장르 선택",
                                        style: notoSansTextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            textColor: greyText))
                                  ],
                                ),
                                Container(
                                    padding: paddingH20V5,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 3,
                                            color: _formTextField["genre"]
                                                        ["state"] ==
                                                    0
                                                ? Colors.transparent
                                                : _formTextField["genre"]
                                                            ["state"] ==
                                                        1
                                                    ? onSuccess
                                                    : onError)),
                                    child: MultiChoiceChip(
                                        choiceChipType: 1,
                                        typeMap: genreType,
                                        onSelectionChanged: genreTypeChanged)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // desc - text
                            FormBuilderTextField(
                              controller: _formTextField["desc"]["controller"],
                              name: "desc",
                              decoration: borderTextInputBox(
                                  displaySuffixIcon: true,
                                  onPressed: () => _formTextField["desc"]
                                          ["controller"]
                                      .text = "",
                                  icon: Icon(FeatherIcons.edit3,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 설명",
                                  validate: _formTextField["desc"]["state"]),
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
                                    Icon(FeatherIcons.hash,
                                        size: 24, color: themeGrayText),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "프로젝트 지원자 선택",
                                      style: notoSansTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          textColor: greyText),
                                    )
                                  ],
                                ),
                                Container(
                                    padding: paddingH20V5,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 3,
                                            color: _formTextField["genre"]
                                                        ["state"] ==
                                                    0
                                                ? Colors.transparent
                                                : _formTextField["genre"]
                                                            ["state"] ==
                                                        1
                                                    ? onSuccess
                                                    : onError)),
                                    child: MultiChoiceChip(
                                        choiceChipType: 0,
                                        typeMap: applicantType,
                                        onSelectionChanged:
                                            applicantTypeChanged)),
                              ],
                            ),
                            // prefer - text
                            FormBuilderTextField(
                              name: "prefer",
                              decoration: borderTextInputBox(
                                  displaySuffixIcon: true,
                                  onPressed: () => _formTextField["prefer"]
                                          ["controller"]
                                      .text = "",
                                  icon: Icon(FeatherIcons.heart,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 우대사항",
                                  validate: _formTextField["prefer"]["state"]),
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
                            FormBuilderDropdown(
                              name: "location",
                              items: locations
                                  .map((location) => DropdownMenuItem(
                                        value: location,
                                        child: Text('$location'),
                                      ))
                                  .toList(),
                              allowClear: true,
                              clearIcon: Icon(FeatherIcons.xCircle, size: 20,),
                              decoration: borderTextInputBox(
                                  displaySuffixIcon: false,
                                  icon: Icon(FeatherIcons.mapPin,
                                      size: 24, color: themeGrayText), labelText: '프로젝트 근무지역'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ])),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: themeOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: paddingH20V5),
                      onPressed: () => validateWholeForm(),
                      child: Text(
                        "지원하기",
                        style: notoSansTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.white),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}

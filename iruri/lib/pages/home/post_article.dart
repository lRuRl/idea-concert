import 'dart:io';
// DateFormat
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iruri/components/input_decoration.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';
import 'package:iruri/util/data_article.dart';

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
  ArticleAPI api;
  Article uploadData;
  File thumbnail;
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
  //  style
  var formTextStyle = notoSansTextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, textColor: greyText);
  // validator
  formValidator(BuildContext context, {int maxLength}) => maxLength != null
      ? FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: "필수항목입니다."),
          FormBuilderValidators.maxLength(context, maxLength)
        ])
      : FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: "필수항목입니다."),
        ]);

  @override
  void initState() {
    super.initState();
    // api
    api = new ArticleAPI();
    // controller
    controller = new ScrollController();
    // data
    _formTextField = new Map<String, Map<String, dynamic>>.from({
      "dueDate": {"controller": TextEditingController(), "state": 0},
      // multi choices
      "applicants": {"controller": null, "state": 0},
      "genres": {"controller": null, "state": 0},
      // Condition
      "projectType": {"controller": TextEditingController(), "state": 0},
      "contractType": {"controller": TextEditingController(), "state": 0},
      "wage": {"controller": TextEditingController(), "state": 0},
      // Content
      "title": {"controller": TextEditingController(), "state": 0},
      "desc": {"controller": TextEditingController(), "state": 0},
      "prefer": {"controller": TextEditingController(), "state": 0},
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
                            // project name
                            FormBuilderTextField(
                              controller: _formTextField["title"]["controller"],
                              name: "title",
                              enableInteractiveSelection: true,
                              decoration: borderTextInputBox(
                                  displaySuffixIcon: true,
                                  onPressed: () => resetFormField("title"),
                                  icon: Icon(FeatherIcons.tag,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 제목",
                                  hintText: "18자 이내로 제목을 입력해주세요",
                                  validate: _formTextField["title"]["state"]),
                              validator: formValidator(context, maxLength: 18),
                            ),
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
                                          image: thumbnail != null
                                              ? FileImage(thumbnail)
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
                            // period - date picker
                            FormBuilderDateTimePicker(
                              controller: _formTextField["dueDate"]
                                  ["controller"],
                              name: "dueDate",
                              inputType: InputType.both,
                              format: DateFormat('yyyy-MM-dd hh:mm, EEE'),
                              decoration: borderTextInputBox(
                                  onPressed: () => resetFormField("dueDate"),
                                  displaySuffixIcon: false,
                                  icon: Icon(FeatherIcons.calendar,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 공고 마감일",
                                  validate: _formTextField["dueDate"]["state"]),
                              validator: formValidator(context),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: size.width * 0.4,
                                      child: FormBuilderDateTimePicker(
                                          name: "periodfrom",
                                          format: DateFormat('yyyy-MM-dd'),
                                          inputType: InputType.date,
                                          decoration: borderTextInputBox(
                                            displaySuffixIcon: false,
                                            labelText: "시작일",
                                          ),
                                          validator: formValidator(context))),
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: FormBuilderDateTimePicker(
                                      name: "periodto",
                                      format: DateFormat('yyyy-MM-dd'),
                                      inputType: InputType.date,
                                      decoration: borderTextInputBox(
                                        displaySuffixIcon: false,
                                        labelText: "종료일",
                                      ),
                                      validator: formValidator(context),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 20,
                            ),
                            // genre - multi choice
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 5.0,
                              children: <Widget>[
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Icon(FeatherIcons.hash,
                                        size: 24, color: themeGrayText),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("프로젝트 장르 선택", style: formTextStyle)
                                  ],
                                ),
                                Container(
                                    padding: paddingH20V5,
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 3,
                                            color: _formTextField["genres"]
                                                        ["state"] ==
                                                    0
                                                ? Colors.transparent
                                                : _formTextField["genres"]
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
                                controller: _formTextField["desc"]
                                    ["controller"],
                                name: "desc",
                                enableInteractiveSelection: true,
                                decoration: borderTextInputBox(
                                    displaySuffixIcon: true,
                                    onPressed: () => resetFormField("desc"),
                                    icon: Icon(FeatherIcons.edit3,
                                        size: 24, color: themeGrayText),
                                    labelText: "프로젝트 설명",
                                    validate: _formTextField["desc"]["state"]),
                                maxLines: null,
                                validator: formValidator(context)),
                            SizedBox(
                              height: 20,
                            ),
                            // applicant - multi choice
                            Wrap(
                              direction: Axis.vertical,
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
                                      style: formTextStyle,
                                    )
                                  ],
                                ),
                                Container(
                                    padding: paddingH20V5,
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 3,
                                            color: _formTextField["applicants"]
                                                        ["state"] ==
                                                    0
                                                ? Colors.transparent
                                                : _formTextField["applicants"]
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
                            // Condition - contractType
                            FormBuilderTextField(
                                name: "contractType",
                                enableInteractiveSelection: true,
                                decoration: borderTextInputBox(
                                    displaySuffixIcon: false,
                                    icon: Icon(FeatherIcons.type,
                                        size: 24, color: themeGrayText),
                                    labelText: "프로젝트 계약종류",
                                    validate: _formTextField["contractType"]
                                        ["state"]),
                                validator: formValidator(context)),
                            SizedBox(height: 20),
                            FormBuilderTextField(
                                name: "projectType",
                                enableInteractiveSelection: true,
                                decoration: borderTextInputBox(
                                    displaySuffixIcon: false,
                                    icon: Icon(FeatherIcons.type,
                                        size: 24, color: themeGrayText),
                                    labelText: "프로젝트 종류",
                                    validate: _formTextField["projectType"]
                                        ["state"]),
                                validator: formValidator(context)),
                            SizedBox(height: 20),
                            FormBuilderTextField(
                                name: "wage",
                                enableInteractiveSelection: true,
                                decoration: borderTextInputBox(
                                    displaySuffixIcon: false,
                                    icon: Icon(FeatherIcons.dollarSign,
                                        size: 24, color: themeGrayText),
                                    labelText: "급여(월)",
                                    validate: _formTextField["wage"]["state"]),
                                validator: formValidator(context)),
                            SizedBox(height: 20),
                            // prefer - text
                            FormBuilderTextField(
                                name: "prefer",
                                enableInteractiveSelection: true,
                                decoration: borderTextInputBox(
                                  displaySuffixIcon: false,
                                  icon: Icon(FeatherIcons.heart,
                                      size: 24, color: themeGrayText),
                                  labelText: "프로젝트 우대사항",
                                ),
                                validator: formValidator(context)),
                            SizedBox(height: 20),
                            // location - scroll
                            FormBuilderDropdown(
                                onChanged: (value) => setState(() {
                                      location = value;
                                    }),
                                name: "location",
                                items: locations
                                    .map((location) => DropdownMenuItem(
                                          value: location,
                                          child: Text('$location'),
                                        ))
                                    .toList(),
                                decoration: borderTextInputBox(
                                    displaySuffixIcon: false,
                                    icon: Icon(FeatherIcons.mapPin,
                                        size: 24, color: themeGrayText),
                                    labelText: '프로젝트 근무지역'),
                                validator: formValidator(context)),
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
                      onPressed: () => uploadTask()
                          .then((value) => Navigator.pop(context))
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: Text('새로운 게시글이 등록되었습니다 !')))),
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

  void resetFormField(String field) {
    setState(() {
      _formTextField[field]["controller"].text = "";
    });
  }

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

  void onThumbnailUploadPressed() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        // downsize image
        maxHeight: 600,
        maxWidth: 450);
    setState(() {
      if (pickedFile != null) {
        thumbnail = File(pickedFile.path);
      } else {
        print("no image selected");
      }
    });
  }

  List<String> pickedApplicants() {
    List<String> res = [];
    applicantType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) res.add(outerKey);
    });
    return res;
  }

  List<String> pickedGenres() {
    List<String> res = [];
    genreType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) res.add(outerKey);
    });
    return res;
  }

  // ignore: slash_for_doc_comments
  void setItemFromDropDown(String item) => location = item;

  void setUploadData() {
    // save current state
    if (this.thumbnail != null) {
      setState(() {
        uploadData = new Article(
            contracts: [],
            members: [],
            imagePath: thumbnail.path,
            image: null,
            detail: new Detail(
                location: location,
                writer: 'tester',
                applicants: [],
                status: '모집중',
                reportedDate: DateFormat('yyyy-MM-ddTHH:mm:ss.mmm')
                    .format(new DateTime.now())
                    .toString(),
                dueDate: DateFormat('yyyy-MM-ddTHH:mm:ss.mmm')
                    .format(_formKey.currentState.value["dueDate"])
                    .toString(),
                period: new Period(
                    from: DateFormat('yyyy-MM-ddTHH:mm:ss.mmm')
                        .format(_formKey.currentState.value["periodfrom"])
                        .toString(),
                    to: DateFormat('yyyy-MM-ddTHH:mm:ss.mmm')
                        .format(_formKey.currentState.value["periodto"])
                        .toString()),
                condition: new Condition(
                  projectType: _formKey.currentState.value["projectType"],
                  contractType: _formKey.currentState.value["contractType"],
                  wage: _formKey.currentState.value["wage"],
                ),
                content: new Content(
                    title: _formKey.currentState.value["title"],
                    desc: _formKey.currentState.value["desc"],
                    prefer: _formKey.currentState.value["prefer"],
                    tags: pickedApplicants(),
                    genres: pickedGenres())));
      });
    } else
      throw Exception('thumbnail not uploaded');
  }

  // thumbnail upload button pressed
  void setValidationState(String key, int state) {
    setState(() {
      _formTextField[key]["state"] = state;
    });
    // print("$key state is set to $state");
  }

  Future<void> uploadTask() async {
    // 1. valid
    // 2. setState
    var validRes = validateWholeForm();
    print('validRes : ' + validRes.toString());
    if (validRes) {
      // 3. post
      return await api.postNewArticle(uploadData, thumbnail.path);
    } else {
      print('validation failed');
    }
  }

  bool validateApplicant() {
    int applicant = 0;
    applicantType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) applicant++;
    });
    return applicant > 0 ? true : false;
  }

  bool validateGenre() {
    int genre = 0;
    genreType.forEach((outerKey, innerKey) {
      if (innerKey.values.first) genre++;
    });
    return genre > 0 ? true : false;
  }

  /**
   *  전체 Form을 올바르게 입력했는지 확인
   *  전체 올바르게 입력 완료한 경우, 모든 state는 +1
   *  올바르게 입력 안된 경우에는 state -1
   *  state 같은 경우, 입력하는 칸에만 해당
   */
  bool validateWholeForm() {
    if (_formKey.currentState.saveAndValidate() &&
        validateApplicant() &&
        validateGenre() &&
        this.thumbnail != null) {
      print('validation success');
      setUploadData();
      return true;
    } else {
      print('validation failed');
      // FAIL TO VALIDATE
      // check current form values
      // set states to -1
      for (final field in _formTextField.entries) {
        final key = field.key;
        final value = field.value;
        if (value["controller"].runtimeType == TextEditingController) {
          if (value["controller"].text.length > 0)
            setValidationState(key, 1);
          else
            setValidationState(key, -1);
        }
      }
      // check multiChoices
      if (!validateApplicant()) setValidationState("applicants", -1);
      if (!validateGenre()) setValidationState("genres", -1);
      print("validation failed" + _formKey.currentState.value.toString());
      return false;
    }
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/components/input_decoration.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
// model
import 'package:iruri/model/user.dart';

class ProfileEdit extends StatefulWidget {
  final User prevData;
  ProfileEdit({this.prevData});
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // scroll
  ScrollController controller;
  // form
  final formKey = GlobalKey<FormBuilderState>();
  // image
  File profileImage;
  PlatformFile portfolio;
  // data
  List<String> roleChoices = [
    '메인글',
    '글콘티',
    '메인그림',
    '그림콘티',
    '캐릭터',
    '채색',
    '선화',
    '뎃셍',
    '후보정'
  ];
  List<String> genreChoices = [
    '스릴러',
    '드라마',
    '판타지',
    '액션',
    '무협',
    '로맨스',
    '학원',
    '코믹',
    '일상',
    '스포츠',
    '시대극',
    '공포',
    'SF'
  ];

  @override
  void initState() {
    super.initState();
    controller = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final prevData = widget.prevData;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // exit
          TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(FeatherIcons.chevronDown, size: 24, color: subLine),
              label: SizedBox()),
          GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: FormBuilder(
                  key: formKey,
                  child: SingleChildScrollView(
                    controller: controller,
                    child: ListView(
                      padding: paddingH20V20,
                      shrinkWrap: true,
                      children: [
                        // Title
                        Text('프로필 수정', style: articleTitleTextStyle),
                        SizedBox(height: 20),

                        /// [Form] the form for personal update
                        /// [image] on left side and [nickname, phoneNumber, career] are on right side
                        /// all the texts will be saved with formKey through global key
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // profile image
                              Stack(
                                alignment: AlignmentDirectional.centerStart,
                                children: <Widget>[
                                  Container(
                                    width: size.width * 0.4,
                                    height: size.width * 0.4,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: subLine),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: profileImage != null
                                                ? FileImage(profileImage)
                                                : AssetImage(
                                                    "assets/default.png"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                    right: 10.0,
                                    top: 10.0,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 16.0,
                                            primary: themeOrange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8) // 8px
                                                )),
                                        onPressed: onProfileImageUploadPressed,
                                        child: Text("수정",
                                            style: notoSansTextStyle(
                                                fontSize: 14,
                                                textColor: Colors.white,
                                                fontWeight: FontWeight.w600))),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  subComponentOnRight(
                                      nameKor: '닉네임',
                                      nameEng: 'nickname',
                                      width: size.width * 0.4,
                                      initialValue:
                                          prevData.profileInfo.nickname != null
                                              ? prevData.profileInfo.nickname
                                              : ''),
                                  SizedBox(height: 10),
                                  subComponentOnRight(
                                      nameKor: '연락처',
                                      nameEng: 'phoneNumber',
                                      width: size.width * 0.4,
                                      initialValue:
                                          prevData.profileInfo.phoneNumber !=
                                                  null
                                              ? prevData.profileInfo.phoneNumber
                                              : ''),
                                  SizedBox(height: 10),
                                  subComponentOnRight(
                                      nameKor: '경력',
                                      nameEng: 'career',
                                      width: size.width * 0.4,
                                      initialValue:
                                          prevData.profileInfo.career != null
                                              ? prevData.profileInfo.career
                                              : ''),
                                ],
                              )
                            ]),
                        SizedBox(height: 20),

                        /// [multiChoices] are available here
                        /// [roles, genres] will be selected using multichoice
                        subComponentMultiChoice(
                            nameKor: '전문분야',
                            nameEng: 'roles',
                            map: roleChoices,
                            initialValue: prevData.profileInfo.roles),
                        subComponentMultiChoice(
                            nameKor: '선호장르',
                            nameEng: 'genres',
                            map: genreChoices,
                            initialValue: prevData.profileInfo.genres),
                        divider,
                        SizedBox(height: 10),
                        subComponentFileUpload(nameKor: '포트폴리오 업로드'),
                        SizedBox(height: 20),
                        /// [updateProfile] by tap below button
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: primary,
                          ),
                          child: Text("수정하기", style: buttonWhiteTextStyle),
                          onPressed: () => print('dd'),
                        )
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  void onProfileImageUploadPressed() async {
    final picked = await ImagePicker().getImage(
        source: ImageSource.gallery, // downsize image
        maxHeight: 600,
        maxWidth: 450);
    if (picked != null) {
      setState(() {
        profileImage = File(picked.path);
      });
    }
  }

  Container subComponentOnRight(
          {@required String nameKor,
          @required String nameEng,
          @required double width,
          @required String initialValue}) =>
      Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nameKor, style: articleWriterTextStyle),
              SizedBox(height: 5),
              Container(
                  height: 30,
                  child: new FormBuilderTextField(
                    name: nameEng,
                    initialValue: initialValue,
                    decoration: borderTextInputBox(displaySuffixIcon: false),
                    style: TextStyle(fontSize: 12, color: greyText),
                  )),
            ],
          ));
  Container subComponentMultiChoice(
          {@required String nameKor,
          @required String nameEng,
          @required List<String> map,
          List<String> initialValue}) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nameKor, style: articleWriterTextStyle),
            FormBuilderCheckboxGroup(
              name: nameEng,
              options:
                  map.map((e) => FormBuilderFieldOption(value: e)).toList(),
              initialValue: initialValue,
              activeColor: primary,
              decoration: InputDecoration(border: InputBorder.none),
            )
          ],
        ),
      );
  Container subComponentFileUpload({@required String nameKor}) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nameKor, style: articleWriterTextStyle),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  portfolio != null ? portfolio.name : '정보가 없습니다.',
                  style: articleTagTextStyle,
                  maxLines: null,
                ),
                TextButton.icon(
                    onPressed: () async {
                      final picked = await FilePicker.platform.pickFiles();
                      if (picked != null) {
                        setState(() {
                          portfolio = picked.files.first;
                        });
                      }
                    },
                    icon: Icon(FeatherIcons.uploadCloud, color: primary),
                    label: Text('업로드', style: TextStyle(color: primary)))
              ],
            )
          ],
        ),
      );
}

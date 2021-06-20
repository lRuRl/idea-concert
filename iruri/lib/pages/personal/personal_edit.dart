// packages
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
// components
import 'package:iruri/components/component.dart';
import 'package:iruri/components/input_decoration.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';
// provider
import '../../provider.dart';
import 'package:provider/provider.dart';
// api
import '../../util/api_user.dart' as api;
// model
import 'package:iruri/model/user.dart';

/// [userData] is for previous data
/// needed for initial Data in edit form
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
    /// [prevData] is input Data from parent Widget
    /// [size] is for MediaQuery dynamic size
    final prevData = widget.prevData;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        controller: controller,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: FormBuilder(
              key: formKey,
              child: ListView(
                controller: controller,
                padding: paddingH20V20,
                shrinkWrap: true,
                children: [
                  // exit
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      child: TextButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(FeatherIcons.chevronDown,
                              size: 24, color: subLine),
                          label: SizedBox())),
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
                                          : prevData.imageChunk != null 
                                          ? MemoryImage(base64Decode(prevData.imageChunk))
                                          : AssetImage("assets/default.png"),
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
                                              BorderRadius.circular(8) // 8px
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
                            subComponentwithWidth(
                                nameKor: '닉네임',
                                nameEng: 'nickname',
                                width: size.width * 0.4,
                                initialValue:
                                    prevData.profileInfo.nickname != null
                                        ? prevData.profileInfo.nickname
                                        : '',
                                isLimit: true),
                            SizedBox(height: 10),
                            subComponentwithWidth(
                                nameKor: '연락처',
                                nameEng: 'phoneNumber',
                                width: size.width * 0.4,
                                initialValue:
                                    prevData.profileInfo.phoneNumber != null
                                        ? prevData.profileInfo.phoneNumber
                                        : '',
                                isLimit: true),
                            SizedBox(height: 10),
                            subComponentwithWidth(
                                nameKor: '경력',
                                nameEng: 'career',
                                width: size.width * 0.4,
                                initialValue:
                                    prevData.profileInfo.career != null
                                        ? prevData.profileInfo.career
                                        : '',
                                isLimit: true),
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
                  subComponentwithWidth(
                      nameKor: '자기소개',
                      nameEng: 'desc',
                      width: size.width,
                      initialValue: prevData.profileInfo.desc != null
                          ? prevData.profileInfo.desc
                          : '',
                      isLimit: false),
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
                    onPressed: () => uploadTask(context),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )));
  }

  /// component for ImageButton in Profile
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

  /// the component with [FromBuilderTextField]
  /// [nameKor] is for Text value which is viewed in application
  /// [nameEng] is name for data, upload to server
  /// [width] is display size,
  /// [initialValue] is data for initial value set in TextField
  /// [isLimit] to have maxLine:null, but not used yet
  Container subComponentwithWidth(
          {@required String nameKor,
          @required String nameEng,
          @required double width,
          @required String initialValue,
          bool isLimit}) =>
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
                    /// [TODO] maxLine null is not showing any text inside
                    /// [maxLine : null] needs [expand : true]
                    decoration: borderTextInputBox(displaySuffixIcon: false),
                    style: TextStyle(fontSize: 12, color: greyText),
                  )),
            ],
          ));
  
  /// the component with [FormBuilderCheckboxGroup]
  /// [nameKor] is for Text value which is viewed in application
  /// [nameEng] is name for data, upload to server
  /// [map] is for base data to be viewed in application
  /// [initialValue] is for data which is uploaded in server before
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

  /// the component with [TextButton.icon]
  /// [nameKor] is for Text value which is viewed in application
  /// component for file upload
  /// uploaded file is saved at [portfolio] with file path
  /// only single file can be uploaded
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
                  portfolio != null ? portfolio.name : widget.prevData.portfolio != null ? widget.prevData.portfolio.substring(widget.prevData.portfolio.indexOf('-')+1) : '정보가 없습니다.',
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

  /// upload files and text together
  /// this function needs params that declared globally
  Future<void> uploadTask(BuildContext context) async {
    /// set the [User Object] using setState(() {});
    /// through [formKey] used upon
    /// #1 save current key state by [formKey.save]
    formKey.currentState.save();

    /// #2 set [User] object
    User uploadUser = new User(

        /// properties that are same as before
        id: widget.prevData.id,
        pw: widget.prevData.pw,
        uid: widget.prevData.uid,
        hasSigned: widget.prevData.hasSigned,
        image: widget.prevData.image,
        portfolio: widget.prevData.portfolio,

        /// properties updated
        /// [nickname, phoneNumber,career,roles, genres, desc]
        profileInfo: ProfileInfo(
            /// not updated [name, programs, location]
            name: widget.prevData.profileInfo.name,
            programs: widget.prevData.profileInfo.programs,
            location: widget.prevData.profileInfo.location,
            /// updated property below
            nickname: formKey.currentState.value['nickname'],
            phoneNumber: formKey.currentState.value['phoneNumber'],
            career: formKey.currentState.value['career'],
            roles: formKey.currentState.value['roles'],
            genres: formKey.currentState.value['genres'],
            desc: formKey.currentState.value['desc']));

    /// #3 use [api] to save result
    await api.UserAPI()
        .updateUserProfile(uploadUser, profileImage, portfolio)

        /// pop screen using [Navigator.pop] and then show snack bar with msg
        /// using [ScaffoldMessenger]
        .then((value) => Navigator.pop(context))
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('성공적으로 업데이트 했습니다.'))))

        /// set updated user information using [Provider]
        .then((value) async {
      /// get User Info
      /// use [findUserById] function
      final response = await api.UserAPI().findUserById(widget.prevData.uid);
      final reader = context.read<UserState>();
      reader.setUser(response);
    });
  }
}

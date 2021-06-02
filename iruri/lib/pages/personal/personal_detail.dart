import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iruri/components/component.dart';
//components
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
// model
import 'package:iruri/model/user.dart';
import 'package:iruri/pages/personal/personal_edit.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////                              프로필 정보 : 석운                             /////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * fetched Data [userData]
 * use FutureBuilder and fetch data from server
 */
class MyProfile extends StatefulWidget {
  final User userData;
  MyProfile({this.userData});
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var index;
  TextEditingController nicknameEditor_;
  TextEditingController phoneNumberEditor_;
  TextEditingController emailEditor_;

  // edit profile
  var _picker;
  var _image;

  @override
  void initState() {
    super.initState();
    index = false;
  }

  changeIndex() {
    setState(() {
      index = !index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.userData;
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height * 0.5,
        padding: paddingH20V20,
        child: Column(
          children: <Widget>[
            //프로필 상단 부분
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("프로필 정보",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    TextButton.icon(
                      // edit profile
                      onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (context) => ProfileEdit(prevData: data)),
                      icon:
                          Icon(FeatherIcons.edit, size: 20, color: primaryLine),
                      label: SizedBox(),
                      style: TextButton.styleFrom(
                          alignment: Alignment.centerRight),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            Expanded(
                flex: 4,
                child:
                    //프로필 하단 부분
                    /// [profileImage] only byte stream from server
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              decoration: BoxDecoration(
                                color: themeLightGrayOpacity20,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: widget.userData.image != null
                                  ? ImageWrapper(image: widget.userData.image)
                                  : Image.asset('assets/default.png'))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 6,
                          child: Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
                              children: [
                            subProfileItem(
                                '닉네임',
                                Text(data.profileInfo.nickname != null
                                    ? data.profileInfo.nickname
                                    : "정보가 없습니다.",)),
                            subProfileItem(
                                '전문분야',
                                Text(data.profileInfo.roles.length != 0
                                    ? data.profileInfo.roles
                                        .toString()
                                        .replaceAll(RegExp(r"(\[)|(\])"), '')
                                    : "정보가 없습니다.")),
                            subProfileItem(
                                '연락처',
                                Text(data.profileInfo.phoneNumber != null
                                    ? data.profileInfo.phoneNumber
                                    : "정보가 없습니다.")),
                            subProfileItem('email',
                                Text(data.id != null ? data.id : "정보가 없습니다.")),
                            subProfileItem(
                                '선호장르',
                                Text(data.profileInfo.genres.length != 0
                                    ? data.profileInfo.genres
                                        .toString()
                                        .replaceAll(RegExp(r"(\[)|(\])"), '')
                                    : "정보가 없습니다.")),
                            subProfileItem(
                                '경력',
                                Text(data.profileInfo.career != null
                                    ? data.profileInfo.career
                                    : "정보가 없습니다.")),
                          ])),
                    ])),
            divider,
            SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('자기소개', style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      data.profileInfo.desc != null
                          ? data.profileInfo.desc
                          : '정보가 없습니다.',
                      textAlign: TextAlign.left)
                ],
              ),
            )
          ],
        ));
  }

  Container subProfileItem(String name, Widget child) => Container(
        margin: marginH3V3,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text(name), child],
        ),
      );

  //그림 수정 버튼
  Widget confirmImageChangeButton() {
    return Container(
        alignment: Alignment.center,
        width: 40,
        height: 20,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: RaisedButton(
          padding: EdgeInsets.all(3),
          color: themeDeepBlue,
          onPressed: _getImage,
          child:
              Text("수정", style: TextStyle(color: Colors.white, fontSize: 10)),
        ));
  }

  Future _getImage() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image.path;
      });
    }
  }

  //수정 화면에서 "수정하기" 버튼 => 누르면 원래 화면으로 돌아감 => 내용 수정은 차후로
  Widget confirmChangeButton() {
    return Container(
        alignment: Alignment.center,
        width: 80,
        height: 30,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: RaisedButton(
          padding: EdgeInsets.all(3),
          color: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
          onPressed: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Center(child: Text('수정이 완료되었습니다')),
                    content: Container(
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                changeIndex();
                                // updateDB(User(
                                //     uid: this._id,
                                //     portfolio: null,
                                //     profileInfo: ProfileInfo(
                                //       nickname: nicknameEditor_.text,
                                //       phoneNumber: phoneNumberEditor_.text,
                                //     )));
                              },
                              child: Text("확인",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                primary: themeDeepBlue,
                                onPrimary: Colors.white,
                              ))),
                    ));
              }),
          child: Text("저장하기", style: TextStyle(color: Colors.white)),
        ));
  }

  //초기 프로필 정보 화면에서 연필모양 아이콘 => 누르면 수정하는 화면으로 바뀜
  Widget changeIcon() {
    return IconButton(
      icon: Icon(FeatherIcons.edit),
      iconSize: 20,
      onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Center(child: Text('수정하시겠습니까')),
                content: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: themeDeepBlue,
                        ),
                        child: Text("취소",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    )),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                changeIndex();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0xf2, 0xa2, 0x0c, 1),
                              ),
                              child: Text("확인",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ))),
                  ],
                ));
          }),
    );
  }

  //프로필 정보 화면 초기상태
  Widget showProfileContent(final width, final height, String nickname,
      String phoneNumber, String email, List<String> roles) {
    return Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
        children: [
      Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          alignment: Alignment.topCenter,
          child: Text(
            nickname != null ? nickname : 'nickname',
            style: TextStyle(fontSize: 9),
          )),
      position(roles),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topCenter,
        child: Text(
          phoneNumber,
          style: TextStyle(fontSize: 9),
        ),
      ),
      Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          alignment: Alignment.topCenter,
          child: Text(
            email,
            style: TextStyle(fontSize: 9),
          )),
    ]);
  }

  //연필 아이콘 누르면 수정하는 화면으로 바뀜
  Widget changeProfileContent(
    TextEditingController nicknameEditor_,
    TextEditingController phoneNumberEditor_,
    TextEditingController emailEditor_,
    final width,
    final height,
    List<String> roles,
  ) {
    return Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
        children: [
      profiletextfield(nicknameEditor_, width, height),
      changePosition(roles),
      profiletextfield(phoneNumberEditor_, width, height),
      profiletextfield(emailEditor_, width, height),
    ]);
  }

  Widget profiletextfield(
      TextEditingController _controller, final width, final height) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
      alignment: Alignment.topLeft,
      width: width * 0.45,
      height: height * 0.025,
      child: TextFormField(
        enabled: true,
        maxLines: 1,
        inputFormatters: [new LengthLimitingTextInputFormatter(25)],
        controller: _controller,
        style: TextStyle(color: themeGrayText, fontSize: 8),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  new BorderSide(color: themeLightGrayOpacity20, width: 1),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  new BorderSide(color: themeLightGrayOpacity20, width: 1),
              borderRadius: BorderRadius.circular(5)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  new BorderSide(color: themeLightGrayOpacity20, width: 1),
              borderRadius: BorderRadius.circular(5)),
          fillColor: themeLightGrayOpacity20,
          filled: true,
          //labelStyle: TextStyle(color: themeGrayText, fontSize: 3),
          //labelText: testInput.nickname,
        ),
      ),
    );
  }

  Widget position(List<String> data) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4)
      bottomMargin = 10;
    else
      bottomMargin = 35;

    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        alignment: Alignment.topCenter,
        width: size.width * 0.45,
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
                            childAspectRatio: 4 / 1.5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3),
                        itemCount: data.length,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () => print('tag pressed'),
                              tag: data[index],
                            ))),
              )
            ]));
  }

  Widget changePosition(List<String> data) {
    final size = MediaQuery.of(context).size;
    double bottomMargin;
    if (data.length >= 4)
      bottomMargin = 3;
    else
      bottomMargin = 3;

    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, bottomMargin),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        alignment: Alignment.topCenter,
        width: size.width * 0.45,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: themeLightGrayOpacity20,
          ),
          color: themeLightGrayOpacity20,
        ),
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 1.5,
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3),
                        itemCount: data.length,
                        itemBuilder: (context, index) => TagWrapper(
                              onPressed: () => _showDialog(context),
                              tag: data[index],
                            ))),
              )
            ])));
  }
}

void _showDialog(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("태그 선택"), actions: <Widget>[PositionChange()]);
      });
}

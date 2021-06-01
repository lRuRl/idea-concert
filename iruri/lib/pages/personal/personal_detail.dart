import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iruri/components/component.dart';
//components
import 'package:iruri/components/palette.dart';
// model
import 'package:iruri/model/user.dart';
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

  // updateDB(User data) {
  //   api.updateUserInfo(data);
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var profileContent, icon, changeButton, imageChangeButton;
    return FutureBuilder<User>(
        future: Future.delayed(Duration.zero),
        builder: (context, snapshot) {
          String nickname, email, phoneNumber;
          List<String> roles;
          nickname = snapshot.data.profileInfo.nickname;
          phoneNumber = snapshot.data.profileInfo.phoneNumber;
          email = snapshot.data.id;
          roles = snapshot.data.profileInfo.roles;

          if (index == false) {
            profileContent = showProfileContent(
                width, height, nickname, email, phoneNumber, roles);
            icon = changeIcon();
            changeButton = Container();
            imageChangeButton = Container();
          } else {
            profileContent = changeProfileContent(nicknameEditor_,
                phoneNumberEditor_, emailEditor_, width, height, roles);
            icon = Container();
            changeButton = confirmChangeButton();
            imageChangeButton = confirmImageChangeButton();
          }

          return Container(
              child: Column(
            children: <Widget>[
              //프로필 상단 부분
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("프로필 정보",
                      style: TextStyle(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left),
                  icon,
                ],
              ),
              //프로필 하단 부분
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //프로필사진 컨테이너
                      width: width * 0.3,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: themeLightGrayOpacity20,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.13,
                            //width: width * 10,
                            //padding: EdgeInsets.all(2),
                            child: //ImageWrapper(imagePath: imagePath),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(color: Colors.red,),),
                          ),
                          imageChangeButton
                        ],
                      ),
                    ),
                    Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
                        children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 3, 0, 10),
                        width: width * 0.15,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "닉네임",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 3, 0, 40),
                        width: width * 0.15,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "포지션",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        width: width * 0.15,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "연락처",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        width: width * 0.15,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "이메일",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ]),
                    profileContent,
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: changeButton,
                )
              ])
            ],
          ));

          /*
        Column(//프로필 내용 컨테이너(닉네임, 포지션, 연락처, 이메일)
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            alignment: Alignment.topCenter,
            child: Text(nickname,style: TextStyle(fontSize: 9),)
          ),
          position(roles),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            alignment: Alignment.topCenter,
            child: Text( phoneNumber, style: TextStyle(fontSize: 9),),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            alignment: Alignment.topCenter,
            child: Text(email,style: TextStyle(fontSize: 9),)
          ),
          ]
        );*/
        });
  }

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
      icon: Icon(Icons.create_outlined),
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
            nickname,
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
// packages
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

/// the class which is located at the top of the Personal page
/// needs [userData] which can be loaded from different page
/// or data that is loaded at sign-in
class PersonalDetail extends StatefulWidget {
  final User userData;
  PersonalDetail({this.userData});
  @override
  _PersonalDetailState createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {

  @override
  Widget build(BuildContext context) {
    final data = widget.userData;
    final size = MediaQuery.of(context).size;
    if(widget.userData != null) {
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
                                  ? ImageWrapper(image: widget.userData.imageChunk)
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
                                Text(
                                  data.profileInfo.nickname != null
                                      ? data.profileInfo.nickname
                                      : "정보가 없습니다.",
                                )),
                            subProfileItem(
                                '전문분야',
                                Text(
                                  data.profileInfo.roles.length != 0
                                      ? data.profileInfo.roles
                                          .toString()
                                          .replaceAll(RegExp(r'(\[)|(")|(\])'), '')
                                      : "정보가 없습니다.",
                                  overflow: TextOverflow.visible,
                                )),
                            subProfileItem(
                                '연락처',
                                Text(data.profileInfo.phoneNumber != null
                                    ? data.profileInfo.phoneNumber
                                    : "정보가 없습니다.")),
                            subProfileItem('email',
                                Text(data.id != null ? data.id : "정보가 없습니다.")),
                            subProfileItem(
                                '선호장르',
                                Text(
                                    data.profileInfo.genres.length != 0
                                        ? data.profileInfo.genres
                                            .toString()
                                            .replaceAll(
                                                RegExp(r'(\[)|(")|(\])'), '')
                                        : "정보가 없습니다.",
                                    overflow: TextOverflow.visible)),
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
    else {
      return Center(
        child: Text('정보가 없습니다.'),
      );
    }
  }

  /// the component for sub detailed view
  /// [name] is for view item title
  /// [child] is for child displayed at the right of title(name)
  Container subProfileItem(String name, Widget child) => Container(
        margin: marginH3V3,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(name),
            SizedBox(width: 15),
            Flexible(
              child: child,
            )
          ],
        ),
      );
}

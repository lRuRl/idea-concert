import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/pages/home/muliple_choice_chip.dart';

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

  @override
  void initState() {
    super.initState();
    // controller
    controller = new ScrollController();
    // model
    uploadArticle = new Article();
  }

  final ValueChanged _onChanged = (val) => print(val);

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
      ),
      body: GestureDetector(
          // used for keyboard dismiss
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: <Widget>[
                  // multi choice chip
                  MultiChoiceChip(
                    choiceChipType: 0,
                      typeMap: applicantType,
                      onSelectionChanged: applicantTypeChanged),
                  MultiChoiceChip(
                    choiceChipType: 1,
                      typeMap: genreType,
                      onSelectionChanged: genreTypeChanged),
                  FormBuilder(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        FormBuilderTextField(
                          name: 'age',
                          decoration: InputDecoration(
                            labelText:
                                'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
                          ),
                          onChanged: _onChanged,
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderCheckboxGroup(
                            decoration: InputDecoration(
                                labelText: '지원 받을 작가님들을 선택해주세요.',
                                border: InputBorder.none),
                            activeColor: themeLightOrange,
                            name: 'applicantType',
                            options: [
                              FormBuilderFieldOption(
                                  value: 'write_main', child: Text('메인글')),
                              FormBuilderFieldOption(
                                  value: 'write_conti', child: Text('글콘티')),
                              FormBuilderFieldOption(
                                  value: 'draw_main', child: Text('메인그림')),
                              FormBuilderFieldOption(
                                  value: 'draw_conti', child: Text('그림콘티')),
                              FormBuilderFieldOption(
                                  value: 'draw_dessin', child: Text('뎃셍')),
                              FormBuilderFieldOption(
                                  value: 'draw_line', child: Text('선화')),
                              FormBuilderFieldOption(
                                  value: 'draw_char', child: Text('캐릭터')),
                              FormBuilderFieldOption(
                                  value: 'draw_color', child: Text('채색')),
                              FormBuilderFieldOption(
                                  value: 'draw_after', child: Text('후보정')),
                            ]),
                        FormBuilderDateTimePicker(
                          name: 'date',
                          initialValue: DateTime.now(),
                          inputType: InputType.both,
                          decoration: const InputDecoration(
                            labelText: 'Appointment Time',
                          ),
                          initialTime: TimeOfDay(hour: 8, minute: 0),
                          pickerType: PickerType.cupertino,
                          //locale: Locale.fromSubtags(languageCode: 'fr'),
                        ),
                        FormBuilderRadioGroup<String>(
                          decoration: const InputDecoration(
                            labelText: 'My chosen language',
                          ),
                          name: 'best_language',
                          onChanged: _onChanged,
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          options:
                              ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                                  .map((lang) => FormBuilderFieldOption(
                                        value: lang,
                                        child: Text(lang),
                                      ))
                                  .toList(growable: false),
                          controlAffinity: ControlAffinity.trailing,
                        ),
                      ])),
                  MaterialButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.saveAndValidate()) {
                        print(_formKey.currentState.value);
                      } else {
                        print(_formKey.currentState.value);
                        print('validation failed');
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';
import 'package:iruri/model/article.dart';

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
                        FormBuilderChoiceChip(
                          name: 'choice_chip',
                          decoration: const InputDecoration(
                            labelText: 'Select an option',
                          ),
                          options: [
                            FormBuilderFieldOption(
                                value: 'Test', child: Text('Test')),
                            FormBuilderFieldOption(
                                value: 'Test 1', child: Text('Test 1')),
                            FormBuilderFieldOption(
                                value: 'Test 2', child: Text('Test 2')),
                            FormBuilderFieldOption(
                                value: 'Test 3', child: Text('Test 3')),
                            FormBuilderFieldOption(
                                value: 'Test 4', child: Text('Test 4')),
                          ],
                        ),
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

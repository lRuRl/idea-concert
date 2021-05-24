import 'package:flutter/material.dart';
import 'package:iruri/components/component.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/model/article_sample.dart';
import 'package:iruri/pages/home/project_detail_components.dart';
import 'package:iruri/pages/state/state_utils.dart';

// provider
import 'package:provider/provider.dart';
import 'package:iruri/provider.dart';

class FillContractPage extends StatefulWidget {
  @override
  _FillContractPageState createState() => _FillContractPageState();
}

class _FillContractPageState extends State<FillContractPage> {
  ScrollController scrollController = new ScrollController();
  bool _isLoading = true;
  String pathPDF = "";
  int pages = 0;

  @override
  void initState() {
    super.initState();

    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        _isLoading = false;
      });
    });

    // fromAsset('assets/example.pdf', 'example.pdf').then((f) {
    //   setState(() {
    //     pathPDF = f.path;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Article data = context.watch<CustomRouter>().data;
    // Article data = articleSampleData.first;

    return Scaffold(
        // body
        body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: thumbnail(context, data),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: noticeDetail(context, data),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 5,
                              color: Color.fromRGBO(0xf2, 0xf2, 0xf2, 1)),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: projectCalendar(context, data),
                    ),
                    contractTitle(context),
                    AgreeContract(pdfPath: pathPDF, index: 1),
                    AgreeContract(pdfPath: pathPDF, index: 2),
                    Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: saveContractButton(context)),
                  ]),
            )));
  }
}

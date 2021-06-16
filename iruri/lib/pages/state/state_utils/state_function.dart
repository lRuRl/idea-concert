import 'package:flutter/material.dart';
// Provider
import 'package:path_provider/path_provider.dart';
// Utils
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// article
import 'package:iruri/model/article.dart';

Future<File> createFileOfPdfUrl() async {
  Completer<File> completer = Completer();
  try {
    final url = "http://www.africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");

    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}

Future<File> fromAsset(String asset, String filename) async {
  // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  Completer<File> completer = Completer();

  try {
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}

String getGenreList(List<String> genres) {
  String result = '';
  for (int i = 0; i < genres.length; i++) {
    result += genres[i];
    if (i != genres.length - 1) {
      result += '/';
    }
  }
  return result;
}

List<Widget> rolesLinearTag(List<String> roles) {
  Widget element;
  for (int i = 0; i < roles.length; i++) {
    // element =
    // PositionSmallLinear()
  }
}

List<String> getUidList(Article article) {
  List<String> uidList = [];

  if (article.detail.applicant.drawAfters?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawAfters.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawAfters[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawAfters[i].uid);
    }
  }

  if (article.detail.applicant.drawColors?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawColors.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawColors[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawColors[i].uid);
    }
  }

  if (article.detail.applicant.drawChars?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawChars.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawChars[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawChars[i].uid);
    }
  }

  if (article.detail.applicant.drawLines?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawLines.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawLines[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawLines[i].uid);
    }
  }

  if (article.detail.applicant.drawDessins?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawDessins.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawDessins[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawDessins[i].uid);
    }
  }

  if (article.detail.applicant.drawContis?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawContis.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawContis[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawContis[i].uid);
    }
  }

  if (article.detail.applicant.drawMains?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.drawMains.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.drawMains[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.drawMains[i].uid);
    }
  }

  if (article.detail.applicant.writeMains?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.writeMains.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.writeMains[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.writeMains[i].uid);
    }
  }

  if (article.detail.applicant.writeContis?.isEmpty == false) {
    for (int i = 0; i < article.detail.applicant.writeContis.length; i++) {
      bool isExist = false;
      for (int j = 0; j < uidList.length; j++) {
        if (uidList[j] == article.detail.applicant.writeContis[i].uid) {
          isExist = true;
          break;
        }
      }
      if (isExist == false)
        uidList.add(article.detail.applicant.writeContis[i].uid);
    }
  }
  return uidList;
}

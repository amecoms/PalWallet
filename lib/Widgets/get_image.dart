import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../theme/app_color.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

Future getImage({ImageSource? source}) async {
  ImageSource? imageSource;
  if(source == null) {
    ImageSource? result = await showCupertinoModalPopup(
      context: appContext,
      builder: (BuildContext context) =>
      CupertinoActionSheet(
        title: Text(appLanguage().choose,
          style: appTheme(context).textTheme.headlineLarge,),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, ImageSource.camera);
            },
            child: Text(appLanguage(context).camera,
              style: appTheme(context).textTheme.bodyLarge,),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, ImageSource.gallery);
            },
            child: Text(appLanguage(context).gallery,
              style: appTheme(context).textTheme.bodyLarge,),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLanguage(context).close,
            style: appTheme(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.red
            ),),
        ),
      ),
    );
    imageSource = result;
  } else {
    imageSource = source;
  }
  if (imageSource != null) {
    final picker = ImagePicker();
    XFile? pickedFile;
    try {
      pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50);
      if(pickedFile!=null){
        return File(pickedFile.path);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  } else {
    return null;
  }
}

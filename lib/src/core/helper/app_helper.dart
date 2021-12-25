import 'package:flutter/material.dart';

import '../constants/constant_imports.dart';
import 'size_helper.dart';

/// A convenient class wraps all functions of **AppHelper**
class AppHelper {
  /// This function take a image input of File type
  /// this function show some default cropping ration's after take the input
  /// and return the cropped image as a file

  static void dismissKeyboard({
    required BuildContext ctx,
  }) {
    final currentFocus = FocusScope.of(ctx);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // static Future<File?> cropImage(File? imageFile) async {
  //   var _croppedFile = await ImageCropper.cropImage(
  //     sourcePath: imageFile!.path,
  //     aspectRatioPresets: Platform.isAndroid
  //         ? [
  //             CropAspectRatioPreset.square,
  //             CropAspectRatioPreset.ratio3x2,
  //             CropAspectRatioPreset.original,
  //             CropAspectRatioPreset.ratio4x3,
  //             CropAspectRatioPreset.ratio16x9
  //           ]
  //         : [
  //             CropAspectRatioPreset.original,
  //             CropAspectRatioPreset.square,
  //             CropAspectRatioPreset.ratio3x2,
  //             CropAspectRatioPreset.ratio4x3,
  //             CropAspectRatioPreset.ratio5x3,
  //             CropAspectRatioPreset.ratio5x4,
  //             CropAspectRatioPreset.ratio7x5,
  //             CropAspectRatioPreset.ratio16x9
  //           ],
  //     androidUiSettings: const AndroidUiSettings(
  //         toolbarTitle: 'Carmeleon',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false),
  //     iosUiSettings: const IOSUiSettings(
  //       title: 'Carmeleon',
  //     ),
  //   );
  //
  //   return _croppedFile;
  // }

  static Future<void> showSimpleDialogue<T>({
    bool showOkayButton = false,
    bool showNoButton = false,
    String cancelBtnTitle = 'cancel',
    String okBtnTitle = 'Ok',
    required BuildContext context,
    String title = 'Alert',
    String message = '',
    Function? onClick,
  }) async {
    await showDialog<T>(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: SizeHelper.getDeviceWidth(context) / Dimensions.px3,
                decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(Dimensions.px10)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.px10, right: Dimensions.px10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: Dimensions.px10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBoldText(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.px10,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regularText(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.px25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          if (showNoButton)
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  cancelBtnTitle,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.semiBoldText(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          // Spacer(),
                          if (showOkayButton)
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  okBtnTitle,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.semiBoldText(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              onTap: () {
                                onClick!.call();
                                Navigator.pop(context);
                              },
                            ),
                        ],
                      ),
                      SizedBox(height: Dimensions.px10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

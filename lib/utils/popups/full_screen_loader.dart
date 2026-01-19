import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/common/widgets/loaders/animation_loader.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) =>
          PopScope(canPop: false,
              child: Container(color: HelperFunctions.isDarkMode(Get.context!)
                  ? AppColors.dark
                  : AppColors.light,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const SizedBox(height: 250,),
                  AnimationLoaderWidget(text: text, animation: animation,),
                  ],
                ),)),);
  }
  static void stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
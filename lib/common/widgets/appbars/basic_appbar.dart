import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/device/device_utils.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<IconButton>? suffer;
  final Color? backgroundColor;
  BasicAppbar({super.key, required this.title, this.suffer, this.backgroundColor });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final textColor =  dark?Colors.white:Colors.black;
    final bgColor = backgroundColor ??
        (HelperFunctions.isDarkMode(context)
            ? AppColors.black
            : AppColors.white);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
      child: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: textColor,),
        ),
        centerTitle: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        actions: suffer ?? [Container()],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}

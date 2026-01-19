import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import 'features/message/screens/home/home.dart';
import 'features/message/screens/more/more.dart';
import 'features/personalization/screens/profile/profile.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value],),
      bottomNavigationBar: Obx(() =>
          NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected:(value) {
              controller.selectedIndex.value = value;
              print("CURRENT INDEX ${controller.selectedIndex.value}" );
            } ,
            backgroundColor: dark?AppColors.black:AppColors.white,
            indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)) ,
            indicatorColor: AppColors.primaryColor,
            destinations: const[
              NavigationDestination(icon: Icon(Icons.chat), label: "Chats"),
              NavigationDestination(icon: Icon(Icons.groups), label: "Groups"),
              NavigationDestination(icon: Icon(Icons.account_circle_outlined), label: "Profile"),
              NavigationDestination(icon: Icon(Icons.menu), label: "More"),
            ],
          ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int>selectedIndex = 0.obs;
  final screens = [
    HomeScreen(),
    HomeScreen(),
    ProfileScreen(),
    MoreScreen(),
  ];
}
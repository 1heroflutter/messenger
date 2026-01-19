import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../features/message/screens/add/add_friends.dart';
import '../../../utils/constants/colors.dart';

class CustomAddPopupMenu extends StatelessWidget {
  const CustomAddPopupMenu({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return PopupMenuButton<String>(
      icon: const Icon(Icons.add, color: Colors.white),
      color: dark ? AppColors.black : AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onSelected: (value) {
        if (value == 'add_friend') { }
        if (value == 'create_group') { }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'add_friend',
          onTap: () => Get.to(AddFriendScreen()),
          child: const ListTile(
            leading: Icon(Icons.person_add_alt),
            title: Text("Add Friend"),
          ),
        ),
        const PopupMenuItem(
          value: 'create_group',
          child: ListTile(
            leading: Icon(Icons.groups_outlined),
            title: Text("Create Group"),
          ),
        ),
      ],
    );
  }
}
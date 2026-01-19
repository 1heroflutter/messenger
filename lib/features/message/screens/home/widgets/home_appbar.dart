
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/appbars/main_screen_appbar.dart';
import '../../../../../common/widgets/popup_menu/popup_add_menu_button.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../controllers/friend/friend_request_controller.dart';
import '../../friend_request/friend_request.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final requestController = Get.put(FriendRequestController());
    final isSearching = false.obs;
    final dark = HelperFunctions.isDarkMode(context);

    return Obx(
          () => MainScreenAppbar(
        leading: isSearching.value
            ? null
            : Padding(
          padding: const EdgeInsets.all(AppSizes.sm),
          child: Image.asset(dark ? AppImages.darkAppLogo : AppImages.lightAppLogo),
        ),
        title: isSearching.value
            ? TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black), // Sửa lại màu chữ cho dễ nhìn trên nền trắng
          decoration: InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor: AppColors.white,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        )
            : const Text("E-Chat", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        suffer: [
          /// --- NÚT FRIEND REQUESTS VỚI BADGE ---
          if (!isSearching.value)
            Stack(
              alignment: Alignment.center,
              children: [
                if (requestController.pendingRequests.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${requestController.pendingRequests.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),

          IconButton(
            onPressed: () => isSearching.value = !isSearching.value,
            icon: Icon(isSearching.value ? Icons.close : Icons.search, color: Colors.white),
          ),
          const CustomAddPopupMenu(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}


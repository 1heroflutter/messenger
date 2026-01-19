import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/common/widgets/appbars/main_screen_appbar.dart';
import 'package:messenger/features/message/screens/add/widgets/add_button.dart';
import 'package:messenger/features/message/screens/add/widgets/empty.dart';
import 'package:messenger/features/message/screens/add/widgets/search_input.dart';
import 'package:messenger/features/message/screens/add/widgets/list_users.dart';
import '../../../../common/widgets/appbars/basic_appbar.dart'; // Đường dẫn appbar của bạn
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/add/add_controller.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo controller
    final controller = Get.put(AddController());
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: MainScreenAppbar(
        title: Text(
          "Add Friend",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        isTitleCenter: true,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputWidget(),

              const SizedBox(height: AppSizes.spaceBtwSections),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.featuredUsers.isEmpty) {
                  return Empty(dark: dark);
                }

                return ListUsers(controller: controller);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// FriendRequestScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/utils/constants/image_string.dart';

import '../../../../common/widgets/appbars/basic_appbar.dart';
import '../../../../common/widgets/appbars/main_screen_appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalization/models/user_model.dart';
import '../../controllers/friend/friend_request_controller.dart';

class FriendRequestScreen extends StatelessWidget {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FriendRequestController());
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: MainScreenAppbar(
        title: Text(
          "Friend Request",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        isTitleCenter: true,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pendingRequests.isEmpty) {
          return _buildEmptyState(dark);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Text(
                "${controller.pendingRequests.length} Friend Requests",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(child: _buildRequestList(controller)),
          ],
        );
      }),
    );
  }

  /// --- Danh sách lời mời ---
  Widget _buildRequestList(FriendRequestController controller) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      itemCount: controller.pendingRequests.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        final user = controller.pendingRequests[index];
        print(user.phoneNumber);
        return _buildRequestItem(user, controller);
      },
    );
  }

  /// --- Từng mục lời mời (theo UI trong ảnh) ---
  Widget _buildRequestItem(UserModel user, FriendRequestController controller) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 35,
            backgroundImage: user.avatar.isNotEmpty
                ? NetworkImage(user.avatar)
                : AssetImage(AppImages.lightAppLogo),
          ),
          const SizedBox(width: AppSizes.spaceBtwItems),

          // Thông tin và Nút
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.phoneNumber,
                  style: Theme.of(Get.context!).textTheme.labelLarge
                ),
                Text(
                  "1 mutual friend",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                // Placeholder
                const SizedBox(height: AppSizes.sm),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.acceptRequest(user.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text("Confirm"),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      // Nút Delete
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => controller.rejectRequest(user.id),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool dark) {
    return const Center(child: Text("No pending requests"));
  }
}

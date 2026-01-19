import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/features/message/screens/friend_request/friend_request.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../home/widgets/home_appbar.dart';
import '../user_information/widgets/info_tile.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.black : AppColors.white,
      appBar: HomeAppbar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// 2. Danh sách cài đặt
            // Nhóm Thông báo
            InfoTile(
              icon: Icons.notifications_none,
              title: "Custom Notification",
              onTap: () {},
            ),
            InfoTile(
              icon: Icons.volume_off_outlined,
              title: "Mute Notification",
              trailing: Switch(value: false, onChanged: (val) {}),
            ),
            InfoTile(
              icon: Icons.notifications_active_outlined,
              title: "Custom Notification",
              onTap: () {},
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              child: Divider(color: Colors.white12),
            ),

            // Nhóm Xã hội & Bảo mật
            InfoTile(
              icon: Icons.person_add_outlined,
              title: "Invite Friends",
              onTap: () => Get.to(const FriendRequestScreen()),
            ),
            InfoTile(
              icon: Icons.groups_outlined,
              title: "Joined Groups",
              onTap: () {},
            ),
            InfoTile(
              icon: Icons.history,
              title: "Hide Chat History",
              trailing: Switch(value: true, onChanged: (val) {}),
            ),
            InfoTile(
              icon: Icons.security_outlined,
              title: "Security",
              trailing: Switch(value: true, onChanged: (val) {}),
            ),
            InfoTile(
              icon: Icons.notifications_none,
              title: "Custom Notification",
              onTap: () {},
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              child: Divider(color: Colors.white12),
            ),

            // Nhóm Thông tin ứng dụng
            InfoTile(
              icon: Icons.info_outline,
              title: "About App",
              onTap: () {},
            ),
            InfoTile(
              icon: Icons.help_outline,
              title: "Help Center",
              onTap: () {},
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            // Nút Logout màu đỏ đặc trưng
            InfoTile(
              icon: Icons.logout,
              title: "Logout",
              titleColor: Colors.red,
              onTap: () => _confirmLogout(context),
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  /// Hàm hiển thị Dialog xác nhận đăng xuất dùng Get.defaultDialog
  void _confirmLogout(BuildContext context) {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        // Logic thực hiện logout ở đây (Xóa storage, chuyển về màn Login)
        Get.back();
      },
    );
  }
}

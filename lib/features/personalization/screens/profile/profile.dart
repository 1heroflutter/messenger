import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/common/widgets/loaders/shimmer.dart';
import 'package:messenger/common/widgets/rounded_images/rounded_images.dart';
import 'package:messenger/features/authentication/controllers/profile/profile_controller.dart';
import 'package:messenger/features/personalization/screens/profile/widgets/edit_profile_bottom_sheet.dart';
import 'package:messenger/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:messenger/utils/constants/sizes.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../message/screens/home/widgets/home_appbar.dart';
import '../../controllers/user/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final userController = Get.put(UserController());
    final authRepo = AuthenticationRepository.instance;
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? const Color(0xFF1F222A) : AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppbar(),
      ),
      body: Obx(() {
        // Kiểm tra trạng thái loading
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = userController.user.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// 1. Avatar với nút Edit
              Stack(
                children: [
                  userController.isLoading.value?
                      ShimmerEffect(width: 120, height: 120,radius: 100, )
                      :
                  RoundedImage(
                    width: 120,
                    height: 120,
                    borderRadius: 100,
                    isNetworkImage: user.avatar.isNotEmpty,
                    imageUrl: user.avatar.isNotEmpty
                        ? user.avatar
                        : AppImages.darkAppLogo,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => userController.changeAvatar(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              userController.isLoading.value?
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ShimmerEffect(width: double.infinity, height: 50, ),
              ):
              /// 2. Tên người dùng
              Text(
                user.displayName.isNotEmpty ? user.displayName : "No Name",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// 3. Danh sách thông tin thực từ MongoDB
              userController.isLoading.value?
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ShimmerEffect(width: double.infinity, height: 50, ),
              )
                  :
              ProfileMenu(
                label: "Phone",
                value: user.phoneNumber,
                icon: Iconsax.call,
                context: context,
                dark: dark,
              ),
              userController.isLoading.value?
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ShimmerEffect(width: double.infinity, height: 50, ),
              )
                  :
              ProfileMenu(
                label: "User ID",
                value: user.uid,
                icon: Iconsax.copy,
                context: context,
                dark: dark,
              ),
              userController.isLoading.value?
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ShimmerEffect(width: double.infinity, height: 50, ),
              )
                  :
              ProfileMenu(
                label: "PIN Security",
                value: user.pinEnabled ? "Enabled" : "Disabled",
                icon: Iconsax.lock,
                context: context,
                dark: dark,
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              /// 4. Nút hành động
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showEditProfileBottomSheet(context),
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => authRepo.logout(),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: dark ? Colors.white24 : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showEditProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditProfileBottomSheet(),
    );
  }
}

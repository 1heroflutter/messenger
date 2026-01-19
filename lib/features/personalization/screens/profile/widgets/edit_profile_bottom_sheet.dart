
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/features/authentication/controllers/profile/profile_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/user/user_controller.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.defaultSpace,
        right: AppSizes.defaultSpace,
        top: AppSizes.defaultSpace,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.defaultSpace,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF262933),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: AppSizes.md),
            const Center(child: Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: AppSizes.spaceBtwSections),

            _buildLabel("Name"),
            TextField(
              controller: controller.displayNameController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(controller.displayNameController.text),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),
            _buildLabel("Phone Number"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: _containerDecoration(),
              child: Row(
                children: [
                  const Text("🇻🇳", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  const Text("(+84) ", style: TextStyle(color: Colors.white)),
                  Expanded(
                    child: TextField(
                      controller: controller.phoneController, // Gắn controller
                      enabled: false, // Phone thường không cho sửa trực tiếp
                      style: const TextStyle(color: Colors.white54),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),
            Row(
              children: [
                Expanded(child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24)),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white)))),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.updateUserProfile(),
                    child: controller.isLoading.value
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text("Save"),
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Các hàm Helper để gọn code
Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(color: Colors.white60, fontSize: 12)));

InputDecoration _inputDecoration(String hint) => InputDecoration(
  hintText: hint,
  hintStyle: const TextStyle(color: Colors.white),
  filled: true,
  fillColor: Colors.white12,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
);

BoxDecoration _containerDecoration() => BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(12));
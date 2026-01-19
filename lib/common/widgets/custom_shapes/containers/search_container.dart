// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/device/device_utils.dart';
// import '../../../../utils/helpers/helper_functions.dart';
//
// class SearchContainer extends StatelessWidget {
//   const SearchContainer({
//     super.key,
//     required this.text,
//     this.icon = Iconsax.search_normal,
//     this.showBackground = true,
//     this.showBorder = true,
//     this.padding =
//     const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
//     required this.controller, this.searchProduct, this.searchBrand,
//   });
//
//   final String text;
//   final IconData? icon;
//   final TextEditingController controller;
//   final VoidCallback? searchProduct;
//   final Future<List<BrandModel>> Function()? searchBrand;
//   final bool showBackground, showBorder;
//   final EdgeInsetsGeometry padding;
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = HelperFunctions.isDarkMode(context);
//
//     return Padding(
//       padding: padding,
//       child: Container(
//         width: DeviceUtils.getScreenWidth(context),
//         padding: const EdgeInsets.all(AppSizes.md),
//         decoration: BoxDecoration(
//           color: showBackground
//               ? (dark ? AppColors.dark : AppColors.light)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
//           border: showBorder ? Border.all(color: AppColors.grey) : null,
//         ), // BoxDecoration
//         child: Row(
//           children: [
//             Icon(icon, color: dark ? AppColors.darkerGrey : AppColors.grey),
//             const SizedBox(width: AppSizes.spaceBtwItems),
//             Expanded(
//               child: TextField(
//                 onTapOutside: (event) => FocusScope.of(context).unfocus(),
//                 cursorColor: Theme
//                     .of(context)
//                     .primaryColor,
//                 onSubmitted:(value) {
//                   if (searchProduct != null) {
//                     searchProduct!();
//                   } else if (searchBrand != null) {
//                   }
//                 },
//                 controller: controller,
//                 decoration: InputDecoration(
//                   hintText: text,
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   border: InputBorder.none,
//                   isDense: true,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

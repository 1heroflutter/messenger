import 'package:flutter/material.dart';
import 'package:messenger/common/widgets/rounded_images/rounded_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/helpers/helper_functions.dart';

class CardMessenger extends StatelessWidget {
  const CardMessenger({
    super.key,
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.onTap,
    this.isOnline = false,
  });

  final String image, name, lastMessage, time;
  final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          RoundedImage(imageUrl: image, height: 50,width: 50,borderRadius: 100,isNetworkImage: true,),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.headlineSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        lastMessage,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: unreadCount > 0
              ? (HelperFunctions.isDarkMode(context)
                    ? Colors.white
                    : Colors.black)
              : AppColors.darkGrey,
          fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: AppSizes.xs),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unreadCount > 99 ? '99+' : unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

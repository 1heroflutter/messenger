import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:messenger/utils/constants/app_animations.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/constants/sizes.dart';

class AnimationLoaderWidget extends StatelessWidget {
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const AnimationLoaderWidget({
    super.key,
    required this.text,
    this.animation = AppAnimations.loading,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.height * 0.8,
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: AppColors.light),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

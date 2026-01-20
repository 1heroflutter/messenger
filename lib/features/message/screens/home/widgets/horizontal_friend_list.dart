import 'package:flutter/material.dart';
import 'package:messenger/features/message/screens/home/widgets/user_vertical.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/home/home_controller.dart';
class HorizontalFriendList extends StatelessWidget {
  const HorizontalFriendList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
          ),
          itemCount: controller.friends.length,
          itemBuilder: (context, index) {
            final friend = controller.friends[index];
            return UserVertical(friend: friend);
          },
        ),
      ),
    );
  }
}

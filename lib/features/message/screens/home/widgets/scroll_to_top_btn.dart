import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/home/home_controller.dart';
class ScrollToTopBtn extends StatelessWidget {
  const ScrollToTopBtn({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: SafeArea(
        child: AnimatedOpacity(
          opacity: controller.showScrollToTopBtn.value ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: FloatingActionButton.small(
            onPressed: controller.scrollToTop,
            shape: CircleBorder(),
            child: Icon(
              Icons.vertical_align_top_outlined,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}



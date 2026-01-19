
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.context,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final BuildContext context;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primaryColor,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
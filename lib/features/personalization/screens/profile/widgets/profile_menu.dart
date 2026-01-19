import 'package:flutter/material.dart';
import 'package:messenger/utils/constants/sizes.dart';
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.context,
    required this.dark,
  });

  final String label;
  final String value;
  final IconData icon;
  final BuildContext context;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwItems / 2),
      child: Row(
        children: [
          Icon(icon, size: 20, color: dark ? Colors.white70 : Colors.black54),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: dark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

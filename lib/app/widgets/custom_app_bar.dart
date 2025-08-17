import 'package:flutter/material.dart';
import 'package:fixbuddy/app/constants/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final bool centerTitle;
  final Color backgroundColor;
  final double elevation;
  final Color titleColor;
  final Color iconColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leadingIcon,
    this.onLeadingPressed,
    this.centerTitle = true,
    this.backgroundColor = AppColors.primaryColor,
    this.elevation = 0,
    this.titleColor = Colors.black,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leadingIcon != null
          ? IconButton(
              icon: Icon(leadingIcon, color: iconColor),
              onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

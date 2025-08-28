import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        leading: showBack
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.black,
                ),
                onPressed: onBack ?? () => Navigator.pop(context),
              )
            : null,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

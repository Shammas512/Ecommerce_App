import 'package:flutter/material.dart';

class LoginWidgets extends StatelessWidget implements PreferredSizeWidget {
  final String appbartitle;
  final Color? appbarcolor;
  final List<Widget> actions;

  const LoginWidgets({
    super.key,
    required this.appbartitle,
    this.appbarcolor, // Nullable, no default value
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appbartitle,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: appbarcolor, // Will use the default app bar color if null
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

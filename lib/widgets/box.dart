  import 'package:flutter/material.dart';
  import 'package:bahinko/theme/app_colors.dart';
  import 'package:bahinko/models/person.dart';

  class Box extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onTap;
  const Box(this.child, {super.key, this.color = Colors.white, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0x14000000), blurRadius: 10)
            ],
          ),
          child: child,
        ),
      );
}
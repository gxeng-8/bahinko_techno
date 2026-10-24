  import 'package:flutter/material.dart';
  import 'package:bahinko/theme/app_colors.dart';
  import 'package:bahinko/models/person.dart';

  class Avatar extends StatelessWidget {
  final Person p;
  final double size;
  const Avatar(this.p, {super.key, this.size = 40});
  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: size / 2,
        backgroundColor: p.color,
        child: Text(p.initials,
            style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.3,
                fontWeight: FontWeight.bold)),
      );
}
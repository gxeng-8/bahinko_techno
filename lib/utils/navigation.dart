  import 'package:flutter/material.dart';
  import 'package:bahinko/theme/app_colors.dart';
  import 'package:bahinko/models/person.dart';

  class AppPage extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? bottom;
  final List<Widget>? actions;
  const AppPage(this.title, this.body, {super.key, this.bottom, this.actions});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title,
              style: const TextStyle(fontWeight: FontWeight.w800, color: deep)),
          centerTitle: true,
          actions: actions,
        ),
        body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: body),
        bottomNavigationBar: bottom == null
            ? null
            : Padding(padding: const EdgeInsets.all(16), child: bottom),
      );
}
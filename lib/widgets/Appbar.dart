import 'package:flutter/material.dart';


class AppBar_P extends StatefulWidget  implements PreferredSizeWidget{
   final String title;
   final List<Widget> actions;
   AppBar_P({super.key, required this.title, this.actions = const []});
   

  @override
  State<AppBar_P> createState() => _AppBar_PState();

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBar_PState extends State<AppBar_P> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Action for search button
          },
        ),
        ...widget.actions,
      ],
    );
  }
}
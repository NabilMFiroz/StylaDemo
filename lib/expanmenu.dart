import 'dart:html';

import 'package:flutter/material.dart';

class ExpandMenu extends StatefulWidget {
  const ExpandMenu({Key? key}) : super(key: key);

  @override
  _ExpandMenuState createState() => _ExpandMenuState();
}

class _ExpandMenuState extends State<ExpandMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: buildCard(),
    );
  }

  Widget buildCard() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.orange)),
            child: ExpansionTile(
              title: Text('Open'),
              children: [Text('close'), Text('closed')],
            )),
      );
}

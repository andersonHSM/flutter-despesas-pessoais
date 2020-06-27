import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationBar extends StatelessWidget {
  final List<Widget> appBarActions;

  ApplicationBar({this.appBarActions});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: appBarActions,
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20 * mediaQuery.textScaleFactor),
            ),
            actions: appBarActions,
          );
  }
}

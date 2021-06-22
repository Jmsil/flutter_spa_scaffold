import 'dart:async';

import 'package:flutter/material.dart';

extension AppDrawerController on GlobalKey<DrawerControllerState> {
  Function() getAction(Function() action) {
    return () {
      this.currentState?.close();
      Timer(Duration(milliseconds: 250), action);
    };
  }

  void performAction(Function() action) => Timer(Duration(milliseconds: 250), action);
}
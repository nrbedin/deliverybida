import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => Colors.grey;
  Color get secondary => Color.fromARGB(255, 255, 72, 0);
  Color get black => Colors.black;
}

extension ColorsAppExceptions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:deliverydigital/src/core/env/env.dart';

import './src/app_module.dart';
import './src/app_widget.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy()); //retirar hashtag da url

  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

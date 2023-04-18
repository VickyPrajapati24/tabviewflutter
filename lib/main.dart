import 'package:flutter/material.dart';
import 'myapp.dart';
import '../../injection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

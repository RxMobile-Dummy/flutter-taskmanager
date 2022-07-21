import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/splash.dart';
import 'package:task_management/injection_container.dart' as Sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sl.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}


import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_bloc.dart';
import 'package:task_management/ui/splash.dart';
import 'package:task_management/injection_container.dart' as Sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sl.init();
  HttpOverrides.global = new MyHttpoverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AddNoteBloc>(
            create: (context) => Sl.Sl<AddNoteBloc>(),
          ),
          BlocProvider<AddTaskBloc>(
            create: (context) => Sl.Sl<AddTaskBloc>(),
          ),
          BlocProvider<ProjectBloc>(
            create: (context) => Sl.Sl<ProjectBloc>(),
          ),
        ],
        child: GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Splash(),
        ));
  }
}

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

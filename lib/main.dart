import 'package:churchtick/home/screen/home_page.dart';
import 'package:churchtick/members/controller/members_controller.dart';
import 'package:churchtick/services/attendance/controller/attendance_controller.dart';
import 'package:churchtick/services/create_services/controller/create_service_controller.dart';
import 'package:churchtick/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(kServices);
  await Hive.openBox(kMembersTotal);
  await Hive.openLazyBox(kServiceDate);
  runApp(ChurchTick());
}

class ChurchTick extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServiceDetailsController>(
          create: (context) => ServiceDetailsController(),
        ),
        ChangeNotifierProvider<CreateService>(
          create: (context) => CreateService(),
        ),
        ChangeNotifierProvider<AttendanceController>(
          create: (context) => AttendanceController(),
        ),
      ],
      child: GetMaterialApp(
          title: 'Church Ticker',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.teal,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage()),
    );
  }
}

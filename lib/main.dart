import 'package:ParkSarthi/controller/splace_controller.dart';
import 'package:ParkSarthi/pages/splace_page/splace_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController = Get.put(SplaceController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Parking',
      getPages: pages,
      theme: ThemeData(useMaterial3: true),
      home: const Splace_Screen(),
    );
  }
}

import 'package:assigment_1/app_config/app_binding.dart';
import 'package:assigment_1/app_config/app_pages.dart';
import 'package:assigment_1/app_config/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.LOGIN,
      initialBinding:AppBinding() ,
      getPages: AppPages.pages,
      // translations: AppTra,
    );
  }
}
import 'package:azure_chatbot/app/config/app_colors.dart';
import 'package:azure_chatbot/app/core/base/base_view.dart';
import 'package:azure_chatbot/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeView extends BaseView<HomeController>{
  const HomeView({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Text("helllo worud")
        ],
      ),
    );
  }

}
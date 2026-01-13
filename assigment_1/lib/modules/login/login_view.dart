import 'package:assigment_1/core/base/base_view.dart';
import 'package:assigment_1/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';

class LoginView extends BaseView<LoginController> {

  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
        TextField(controller: controller.usernameController, decoration: InputDecoration(
          hintText: "Enter your username here"
        ),),
        TextField(controller: controller.passwordController, decoration: InputDecoration(
          hintText:"Enter your password" 
        ),),
        Obx(()=>controller.isLoading.value?
          const CircularProgressIndicator()
        :
        ElevatedButton(onPressed: controller.login, child: const Text('Login'))
        )
        ],
      ),
    );
  }
}
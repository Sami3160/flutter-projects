import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:login_route/app/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController auth = Get.find<AuthController>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 60),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(214, 236, 156, 36),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(204, 158, 158, 158),
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(204, 158, 158, 158),
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Obx(() {
                return auth.isLoading.value
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                      onTap: () {
                        auth.login(emailController.text, passwordController.text);
                      },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.orange[800],
                          ),
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

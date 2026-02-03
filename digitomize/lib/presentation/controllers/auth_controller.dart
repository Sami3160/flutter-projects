import 'dart:developer' as developer;
import 'package:digitomize/app/routes/app_pages.dart';
import 'package:digitomize/domain/entities/user.dart';
import 'package:digitomize/domain/usecases/get_profile_usecase.dart';
import 'package:digitomize/domain/usecases/login_usecase.dart';
import 'package:digitomize/domain/usecases/logout_usecase.dart';
import 'package:digitomize/domain/usecases/signin_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Rxn<User> _user = Rxn<User>();
  User? get user => _user.value;
  set user(User? value) => _user.value = value;
  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final SigninUseCase signinUseCase;
  final GetProfileUsecase profileUsecase;
  AuthController({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.signinUseCase,
    required this.profileUsecase,
  });

  final RxBool isLoading = false.obs;
  final RxString errorMessage = "".obs;
  final RxString successMessage = "".obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  @override
  void onInit() async{
    super.onInit();
    try {
      isLoading.value = true;
      final result =await profileUsecase.execute();
      _user.value = result;
      _isLoggedIn.value = true;
    } catch (e) {
      developer.log('AuthController: Profile error: $e');
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      developer.log('AuthController: Starting login process');
      final result = await loginUseCase.execute(
        LoginParams(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      _user.value = result;
      _isLoggedIn.value = true;
      successMessage.value = "Login successful";
      developer.log('AuthController: Login success, navigating to Home');
      Get.toNamed(Routes.HOME);
    } catch (e) {
      developer.log('AuthController: Login error: $e');
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signin() async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      final result = await signinUseCase.execute(
        SigninParams(
          email: emailController.text,
          password: passwordController.text,
          firstname: firstnameController.text,
          lastname: lastnameController.text,
        ),
      );
      successMessage.value = "Signin successful";
      Get.toNamed(Routes.HOME);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    errorMessage.value = "";
    try {
      final result = await logoutUseCase.execute();
      successMessage.value = "Logout successful";
      _user.value = null;
      _isLoggedIn.value = false;
      Get.toNamed(Routes.HOME);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

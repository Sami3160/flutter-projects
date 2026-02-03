import 'package:digitomize/domain/repositories/auth_repository.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'package:digitomize/domain/repositories/contest_repository.dart';
import 'package:digitomize/domain/repositories/hackthon_repository.dart';
import 'package:digitomize/domain/usecases/get_blogs_usecase.dart';
import 'package:digitomize/domain/usecases/get_contest_usecase.dart';
import 'package:digitomize/domain/usecases/get_hackthons_usecase.dart';
import 'package:digitomize/domain/usecases/get_profile_usecase.dart';
import 'package:digitomize/domain/usecases/login_usecase.dart';
import 'package:digitomize/domain/usecases/logout_usecase.dart';
import 'package:digitomize/domain/usecases/signin_usecase.dart';
import 'package:digitomize/presentation/controllers/auth_controller.dart';
import 'package:digitomize/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Inject UseCases associated with Home
    Get.lazyPut(() => GetContestsUseCase(Get.find<ContestRepository>()));
    Get.lazyPut(() => GetBlogsUseCase(Get.find<BlogRepository>()));
    Get.lazyPut(()=>GetHackthonsUseCase(Get.find<HackthonRepository>()));

    // Auth UseCases
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => LogoutUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => SigninUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => GetProfileUsecase(Get.find<AuthRepository>()));

    // Inject Controllers
    Get.lazyPut<HomeController>(() => HomeController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut<AuthController>(
      () => AuthController(
        loginUseCase: Get.find(),
        logoutUseCase: Get.find(),
        signinUseCase: Get.find(),
        profileUsecase: Get.find(),
      ),
      fenix: true,
    );
  }
}

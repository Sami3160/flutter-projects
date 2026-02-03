import 'package:digitomize/data/repositories/auth_repository_impl.dart';
import 'package:digitomize/data/repositories/blog_repository_impl.dart';
import 'package:digitomize/data/repositories/contest_repository_impl.dart';
import 'package:digitomize/data/repositories/hackthon_repository_impl.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'package:digitomize/domain/repositories/contest_repository.dart';
import 'package:digitomize/domain/repositories/hackthon_repository.dart';
import 'package:digitomize/domain/usecases/get_profile_usecase.dart';
import 'package:digitomize/domain/usecases/login_usecase.dart';
import 'package:digitomize/domain/usecases/logout_usecase.dart';
import 'package:digitomize/domain/usecases/signin_usecase.dart';
import 'package:digitomize/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class RepositoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<BlogRepository>(() => BlogRepositoryImpl());
    Get.lazyPut<ContestRepository>(() => ContestRepositoryImpl());
    Get.lazyPut<HackthonRepository>(() => HackthonRepositoryImpl());

    // Auth UseCases
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => LogoutUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => SigninUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => GetProfileUsecase(Get.find<AuthRepository>()));

    // Auth Controller
    Get.put<AuthController>(
      AuthController(
        loginUseCase: Get.find(),
        logoutUseCase: Get.find(),
        signinUseCase: Get.find(),
        profileUsecase: Get.find(),
      ),
      permanent: true,
    );
  }
}

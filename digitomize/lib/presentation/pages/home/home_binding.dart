import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'package:digitomize/domain/repositories/contest_repository.dart';
import 'package:digitomize/domain/usecases/get_blogs_usecase.dart';
import 'package:digitomize/domain/usecases/get_contest_usecase.dart';
import 'package:digitomize/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Inject UseCases associated with Home
    Get.lazyPut(() => GetContestsUseCase(Get.find<ContestRepository>()));
    Get.lazyPut(() => GetBlogsUseCase(Get.find<BlogRepository>()));

    // Inject Controller
    Get.lazyPut<HomeController>(() => HomeController(Get.find(), Get.find()));
  }
}

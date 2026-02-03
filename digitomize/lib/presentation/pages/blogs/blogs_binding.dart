import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'package:digitomize/domain/usecases/get_blogs_usecase.dart';
import 'package:digitomize/presentation/controllers/blog_controller.dart';
import 'package:get/get.dart';

class BlogsBinding extends Bindings {
  @override
  void dependencies() {
    // Add controller when needed
    Get.lazyPut(() => GetBlogsUseCase(Get.find<BlogRepository>()));
    Get.lazyPut<BlogController>(
      () => BlogController(getBlogsUseCase: Get.find()),
      fenix: true,
    );
  }
}

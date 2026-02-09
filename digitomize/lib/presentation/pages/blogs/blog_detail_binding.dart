import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'package:digitomize/domain/usecases/get_one_blog_usecase.dart';
import 'package:digitomize/domain/usecases/get_summary_usecase.dart';
import 'package:digitomize/presentation/controllers/blog_detail_controller.dart';
import 'package:get/get.dart';

class BlogDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetOneBlogUseCase(Get.find<BlogRepository>()));
    Get.lazyPut(()=>GetSummaryUsecase(Get.find<BlogRepository>()));
    Get.lazyPut<BlogDetailController>(
      () => BlogDetailController(getOneBlogUseCase: Get.find(), getSummaryUsecase: Get.find()),
      fenix: true,
    );
  }
}

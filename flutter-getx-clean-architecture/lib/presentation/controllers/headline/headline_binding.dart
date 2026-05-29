import 'package:get/get.dart';
import 'package:getx_clean_architecture/domain/usecases/fetch_headline_use_case.dart';
import 'package:getx_clean_architecture/data/repositories/article_repository.dart';
import 'package:getx_clean_architecture/presentation/controllers/headline/headline_controller.dart';

class HeadlineBinding extends Bindings {
  @override
  void dependencies() {

    //binding for using usecase in controller
    Get.lazyPut(() => FetchHeadlineUseCase(Get.find<ArticleRepositoryIml>()));



    //bindgin for using contoller in view
    Get.lazyPut(() => HeadlineController(Get.find()));
  }
}

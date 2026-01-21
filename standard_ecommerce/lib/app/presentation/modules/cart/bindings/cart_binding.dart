import 'package:get/get.dart';
import 'package:standard_ecommerce/app/data/providers/api_provider.dart';
// Dependencies are likely already provided by HomeBinding or previous screens if we navigate from Home.
// But good practice to define them if routed directly.
// For this simple app, we assume HomeBinding initialized CartController.
// However, if we refresh on Cart Page, we might need them.
import 'package:standard_ecommerce/app/presentation/modules/cart/controllers/cart_controller.dart';
import 'package:standard_ecommerce/app/data/repositories/cart_repository_impl.dart';
import 'package:standard_ecommerce/app/domain/repositories/cart_repository.dart';
import 'package:standard_ecommerce/app/domain/usecases/add_to_cart_usecase.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // If CartController is already in memory (from Home), Get.find work.
    // If not, we lazyPut it.
    // To be safe and avoid duplicates or errors, we can check `Get.isRegistered`.
    // But GetX lazyPut handles this gracefully usually.
    // However, to share state with Home, we want the SAME instance.
    // If HomeBinding already put it, this line is skipped if using `fenix: true` or just standard lazyPut checks.
    // But standard lazyPut replaces? No, it registers the builder.

    // We'll assume HomeBinding did the job for the shared controller.
    // Or providing it here again.

    if (!Get.isRegistered<CartController>()) {
      Get.lazyPut(() => ApiProvider());
      Get.lazyPut<CartRepository>(
        () => CartRepositoryImpl(provider: Get.find()),
      );
      Get.lazyPut(() => AddToCartUseCase(Get.find()));
      Get.lazyPut(() => GetCartByUserUseCase(Get.find()));
      Get.lazyPut(() => CartController(Get.find(), Get.find()));
    }
  }
}

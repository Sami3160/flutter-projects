import 'package:get/get.dart';
import 'package:standard_ecommerce/app/data/providers/api_provider.dart';
import 'package:standard_ecommerce/app/data/repositories/product_repository_impl.dart';
import 'package:standard_ecommerce/app/domain/repositories/product_repository.dart';
import 'package:standard_ecommerce/app/domain/usecases/get_products_usecase.dart';
import 'package:standard_ecommerce/app/presentation/modules/home/controllers/home_controller.dart';
// Import dependencies needed for Cart if we want to add to cart from home
import 'package:standard_ecommerce/app/presentation/modules/cart/controllers/cart_controller.dart';
import 'package:standard_ecommerce/app/data/repositories/cart_repository_impl.dart';
import 'package:standard_ecommerce/app/domain/repositories/cart_repository.dart';
import 'package:standard_ecommerce/app/domain/usecases/add_to_cart_usecase.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    
    // Product
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(provider: Get.find()));
    Get.lazyPut(() => GetProductsUseCase(Get.find()));
    Get.lazyPut(() => SearchProductsUseCase(Get.find()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find()));

    // Cart (for Add to Cart functionality in Home)
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl(provider: Get.find()));
    Get.lazyPut(() => AddToCartUseCase(Get.find()));
    Get.lazyPut(()=>GetCartByUserUseCase(Get.find()));
    Get.lazyPut(() => CartController(Get.find(), Get.find()));
  }
}

import 'package:get/get.dart';
import 'package:standard_ecommerce/app/domain/entities/cart.dart';
import 'package:standard_ecommerce/app/domain/usecases/add_to_cart_usecase.dart';

class CartController extends GetxController {
  final AddToCartUseCase addToCartUseCase;
  final GetCartByUserUseCase getCartByUserUseCase;

  CartController(this.addToCartUseCase,this.getCartByUserUseCase);

  final cart = Rxn<Cart>();
  final allCarts=Rxn<List<Cart>>([]);
  final isLoading = false.obs;
  @override 
  void onInit() async{
    super.onInit();
    try {
      isLoading.value=true;
      allCarts.value=await getCartByUserUseCase(1);
      Get.snackbar('Success', 'Fetched recent cart items');
    }  catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to fetch cart items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(int userId, int productId, int quantity) async {
    try {
      isLoading.value = true;
      final updatedCart = await addToCartUseCase(userId, productId, quantity);
      cart.value = updatedCart;
      allCarts.value=await getCartByUserUseCase(userId);
      Get.snackbar('Success', 'Added to cart');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to cart: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

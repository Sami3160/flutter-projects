import 'package:standard_ecommerce/app/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Cart> addToCart(int userId, int productId, int quantity);
  Future<List<Cart>> getCartByUser(int userId);
}

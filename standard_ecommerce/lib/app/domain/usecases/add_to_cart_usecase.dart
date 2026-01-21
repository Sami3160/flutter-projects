import 'package:standard_ecommerce/app/domain/entities/cart.dart';
import 'package:standard_ecommerce/app/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Cart> call(int userId, int productId, int quantity) async {
    return await repository.addToCart(userId, productId, quantity);
  }
}

class GetCartByUserUseCase {
  final CartRepository repository;
  GetCartByUserUseCase(this.repository);
  Future<List<Cart>> call(int userId) async {
    return await repository.getCartByUser(userId);
  }
}

import 'package:get/get.dart';
import 'package:standard_ecommerce/core/values/strings.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppStrings.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response> login(String username, String password) =>
      post('/auth/login', <String, dynamic>{
        'username': username,
        'password': password,
        'expiresInMins': 30,
      });

  Future<Response> getProducts() => get('/products');

  Future<Response> searchProducts(String query) =>
      get('/products/search?q=$query');

  Future<Response> getCartByUser(int userId)=> get('/carts/user/6');

  Future<Response> addToCart(int userId, List<Map<String, dynamic>> products) =>
      post('/carts/add', {'userId': userId, 'products': products});
}

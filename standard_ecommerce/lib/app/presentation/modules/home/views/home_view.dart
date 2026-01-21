import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_ecommerce/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:standard_ecommerce/app/presentation/modules/cart/controllers/cart_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // We can access CartController here
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: controller.sortProducts,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: controller.goToCart,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => controller.searchProducts(controller.searchController.text),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onSubmitted: (val) => controller.searchProducts(val),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.products.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.thumbnail,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (ctx, _, __) => const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('\$${product.price}'),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add to cart
                                    // Dummy userId = 1 for example
                                    cartController.addToCart(1, product.id, 1);
                                  },
                                  child: const Text('Add to Cart'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

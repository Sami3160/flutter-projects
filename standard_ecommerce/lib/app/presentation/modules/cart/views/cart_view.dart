import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_ecommerce/app/presentation/modules/cart/controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.allCarts.value == null ||
            controller.allCarts.value!.isEmpty) {
          print(controller.allCarts.value);
          return const Center(child: Text('Your cart is empty'));
        }

        final cartList = controller.allCarts.value!;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  final cart = cartList[index];
                  return Column(
                    children: [
                      Text("Cart No, ${cart.id}"),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cart.products.length,
                        itemBuilder: (context, index) {
                          final product = cart.products[index];
                          return ListTile(
                            title: Text(product.title),
                            subtitle: Text(
                              'Qty: ${product.quantity}  Price: \$${product.price}',
                            ),
                            trailing: Text('Total: \$${product.total}'),
                          );
                        },
                      ),
                      // ListTile(
                      //   title: Text("Cart No, ${index}"),

                      //   subtitle: Text('Qty: ${cart.products[0].quantity}  Price: \$${cart.products[0].price}'),
                      //   trailing: Text('Total: \$${cart.total}'),
                      // ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   color: Colors.grey[200],
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            //       Text('\$${cart.total}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            //     ],
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}

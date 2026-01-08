import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/counter_controller.dart';

class CounterPage extends StatelessWidget {
  final CounterController controller = Get.put(CounterController());

  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Counter Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Counter: ${controller.counterText}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: controller.count.value > 10 ? Colors.red : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : SizedBox.shrink(),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.decrement,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: controller.increment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.incrementAsync,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Async Increment'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
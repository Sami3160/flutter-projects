import 'package:assigment_1/core/base/base_controller.dart';
import 'package:get/get.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});
}

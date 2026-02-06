import 'package:azure_chatbot/app/core/base/base_controller.dart';
import 'package:azure_chatbot/domain/usecase/get_ai_response_usecase.dart';
import 'package:get/get.dart';

class HomeController extends BaseController{
  final GetAiResponseUsecase _usecase;
  HomeController(this._usecase);
}
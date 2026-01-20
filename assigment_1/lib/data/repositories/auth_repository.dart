import 'package:assigment_1/core/base/base_repository.dart';
import 'package:assigment_1/core/services/stoarge_service.dart';
import 'package:assigment_1/data/providers/auth_provider.dart';


//combines data from multiple sources, business rules
class AuthRepository extends BaseRepository{
  final AuthProvider provider;
  final StorageService storage;
  AuthRepository(this.provider, this.storage);
  Future<void> login(String username, String password)async{
    final response=await provider.login(username, password);
    await storage.saveToken(response.accessToken);
  }
}
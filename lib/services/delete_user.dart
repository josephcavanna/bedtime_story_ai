import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';

// invokes the delete-user function (supabase edge function)

extension FunctionsClientX on FunctionsClient {
  Future<FunctionResponse> deleteAccount() => invoke('delete-user');
}

abstract class IDeleteUser {
  Future<void> deleteAccount();
}

@Injectable(as: IDeleteUser)
class DeleteUser implements IDeleteUser {
final FunctionsClient functionsClient;

DeleteUser(this.functionsClient);

@override
Future<void> deleteAccount() async {
  await functionsClient.deleteAccount();
}
}
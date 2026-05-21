import 'package:poke_test/data/providers/auth/auth_provider.dart';
import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthProvider _authProvider;

  AuthRepositoryImpl({required this._authProvider});

  @override
  FutureEither<Failure, void> login(String username, String password) async {
    return await _authProvider.login(username, password);
  }
}

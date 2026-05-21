import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';

class AuthProvider {
  FutureEither<Failure, void> login(String username, String password) async {
    if (username.trim() == 'flutter' && password.trim() == 'flutter') {
      await Future.delayed(const Duration(seconds: 2));
      return const .right(null);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      return const .left(Failure.auth(message: 'Invalid username or password'));
    }
  }
}

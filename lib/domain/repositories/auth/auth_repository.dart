import 'package:poke_test/domain/models/eighter/typedefs.dart';
import 'package:poke_test/domain/models/failures/failure.dart';

abstract class AuthRepository {
  FutureEither<Failure, void> login(String username, String password);
}

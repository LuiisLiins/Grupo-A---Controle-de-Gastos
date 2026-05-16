import 'package:get_it/get_it.dart';
import '../providers/auth_provider.dart';
import '../providers/transacao_provider.dart';
import '../providers/config_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Registramos como LazySingleton para que a instância 
  // só seja criada quando for usada pela primeira vez.
  getIt.registerLazySingleton(() => AuthProvider());
  getIt.registerLazySingleton(() => TransacaoProvider());
  getIt.registerLazySingleton(() => ConfigProvider());
}
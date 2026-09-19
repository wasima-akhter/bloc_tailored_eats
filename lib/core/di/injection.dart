import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_email_otp.dart';
import '../../features/auth/domain/usecases/check_forgot_password_otp.dart';
import '../../features/auth/domain/usecases/forgot_password.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/register.dart';
import '../../features/auth/domain/usecases/reset_password.dart';
import '../../features/auth/domain/usecases/send_email_otp.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../network/api_client.dart';
import '../network/network_info.dart';
import '../storage/secure_storage.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ============================================================
  // Core
  // ============================================================

  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo());

  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<SecureStorage>()));

  // ============================================================
  // Auth - Data
  // ============================================================

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );

  // ============================================================
  // Auth - UseCases
  // ============================================================

  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));

  sl.registerLazySingleton<Register>(() => Register(sl<AuthRepository>()));

  sl.registerLazySingleton<SendEmailOtp>(
    () => SendEmailOtp(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<CheckEmailOtp>(
    () => CheckEmailOtp(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ForgotPassword>(
    () => ForgotPassword(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<CheckForgotPasswordOtp>(
    () => CheckForgotPasswordOtp(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ResetPassword>(
    () => ResetPassword(sl<AuthRepository>()),
  );

  // ============================================================
  // Auth - Presentation
  // ============================================================

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      login: sl<Login>(),
      register: sl<Register>(),
      sendEmailOtp: sl<SendEmailOtp>(),
      checkEmailOtp: sl<CheckEmailOtp>(),
      forgotPassword: sl<ForgotPassword>(),
      checkForgotPasswordOtp: sl<CheckForgotPasswordOtp>(),
      resetPassword: sl<ResetPassword>(),
      secureStorage: sl<SecureStorage>(),
    ),
  );
}

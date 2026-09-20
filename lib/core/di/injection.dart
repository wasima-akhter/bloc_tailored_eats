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
import '../../features/consistency/data/datasources/consistency_remote_datasource.dart';
import '../../features/consistency/data/repositories/consistency_repository_impl.dart';
import '../../features/consistency/domain/entities/add_user_weight.dart';
import '../../features/consistency/domain/entities/get_user_consistency.dart';
import '../../features/consistency/domain/entities/get_user_weight.dart';
import '../../features/consistency/domain/repositories/consistency_repository.dart';
import '../../features/consistency/presentation/bloc/consistency_cubit.dart';
import '../../features/friends/data/datasources/friends_remote_datasource.dart';
import '../../features/friends/data/repositories/friends_repository_impl.dart';
import '../../features/friends/domain/repositories/friends_repository.dart';
import '../../features/friends/domain/usecases/accept_friend_request.dart';
import '../../features/friends/domain/usecases/add_friend.dart';
import '../../features/friends/domain/usecases/get_all_friends.dart';
import '../../features/friends/domain/usecases/get_friend_requests.dart';
import '../../features/friends/domain/usecases/get_friend_suggestions.dart';
import '../../features/friends/domain/usecases/reject_friend_request.dart';
import '../../features/friends/domain/usecases/search_friend.dart';
import '../../features/friends/domain/usecases/unfriend.dart';
import '../../features/friends/presentation/bloc/friends_cubit.dart';
import '../../features/goals/data/datasources/goals_local_datasource.dart';
import '../../features/goals/data/datasources/goals_local_datasource_impl.dart';
import '../../features/goals/data/datasources/goals_remote_datasource.dart';
import '../../features/goals/data/repositories/goals_repository_impl.dart';
import '../../features/goals/domain/repositories/goals_repository.dart';
import '../../features/goals/domain/usecases/change_goal_type.dart';
import '../../features/goals/domain/usecases/create_goal.dart';
import '../../features/goals/domain/usecases/delete_goal.dart';
import '../../features/goals/domain/usecases/get_all_goals.dart';
import '../../features/goals/domain/usecases/get_completed_goal_percentage.dart';
import '../../features/goals/domain/usecases/mark_goal_completed.dart';
import '../../features/goals/domain/usecases/update_goal.dart';
import '../../features/goals/presentation/bloc/goals_cubit.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data.dart';
import '../../features/home/presentation/bloc/home_cubit.dart';
import '../../features/nutrition/data/datasources/nutrition_remote_datasource.dart';
import '../../features/nutrition/data/repositories/nutrition_repository_impl.dart';
import '../../features/nutrition/domain/repositories/nutrition_repository.dart';
import '../../features/nutrition/domain/usecases/get_custom_meals.dart';
import '../../features/nutrition/domain/usecases/mark_meal_as_ate.dart';
import '../../features/nutrition/domain/usecases/swap_meal.dart';
import '../../features/nutrition/presentation/bloc/nutrition_cubit.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/complete_profile.dart';
import '../../features/profile/domain/usecases/get_user_profile.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/presentation/bloc/profile_cubit.dart';
import '../database/app_database.dart';
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

  //
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl<HomeRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetHomeData>(
    () => GetHomeData(sl<HomeRepository>()),
  );

  sl.registerFactory<HomeCubit>(
    () => HomeCubit(getHomeData: sl<GetHomeData>()),
  );

  //
  sl.registerLazySingleton<NutritionRemoteDataSource>(
    () => NutritionRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<NutritionRepository>(
    () => NutritionRepositoryImpl(
      remoteDataSource: sl<NutritionRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetCustomMeals>(
    () => GetCustomMeals(sl<NutritionRepository>()),
  );

  sl.registerLazySingleton<MarkMealAsAte>(
    () => MarkMealAsAte(sl<NutritionRepository>()),
  );

  sl.registerLazySingleton<SwapMeal>(() => SwapMeal(sl<NutritionRepository>()));

  sl.registerFactory<NutritionCubit>(
    () => NutritionCubit(
      getCustomMeals: sl<GetCustomMeals>(),
      markMealAsAte: sl<MarkMealAsAte>(),
      swapMeal: sl<SwapMeal>(),
    ),
  );

  sl.registerLazySingleton<ConsistencyRemoteDataSource>(
    () => ConsistencyRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<ConsistencyRepository>(
    () => ConsistencyRepositoryImpl(
      remoteDataSource: sl<ConsistencyRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetUserConsistency>(
    () => GetUserConsistency(sl<ConsistencyRepository>()),
  );

  sl.registerLazySingleton<AddUserWeight>(
    () => AddUserWeight(sl<ConsistencyRepository>()),
  );

  sl.registerLazySingleton<GetUserWeight>(
    () => GetUserWeight(sl<ConsistencyRepository>()),
  );

  sl.registerFactory<ConsistencyCubit>(
    () => ConsistencyCubit(
      getUserConsistency: sl<GetUserConsistency>(),
      addUserWeight: sl<AddUserWeight>(),
      getUserWeight: sl<GetUserWeight>(),
    ),
  );

  // APPDATABSE --
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Goals

  /*
<GoalsRemoteDataSource>

This tells GetIt:

When someone asks me for GoalsRemoteDataSource, give them the registered object.
*/

  sl.registerLazySingleton<GoalsRemoteDataSource>(
    () => GoalsRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton<GoalsLocalDataSource>(
    () => GoalsLocalDataSourceImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<GoalsRepository>(
    () => GoalsRepositoryImpl(
      remoteDataSource: sl<GoalsRemoteDataSource>(),
      localDataSource: sl<GoalsLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  //

  sl.registerLazySingleton<CreateGoal>(() => CreateGoal(sl<GoalsRepository>()));

  sl.registerLazySingleton<GetAllGoals>(
    () => GetAllGoals(sl<GoalsRepository>()),
  );

  sl.registerLazySingleton<MarkGoalCompleted>(
    () => MarkGoalCompleted(sl<GoalsRepository>()),
  );

  sl.registerLazySingleton<UpdateGoal>(() => UpdateGoal(sl<GoalsRepository>()));

  sl.registerLazySingleton<DeleteGoal>(() => DeleteGoal(sl<GoalsRepository>()));

  sl.registerLazySingleton<ChangeGoalType>(
    () => ChangeGoalType(sl<GoalsRepository>()),
  );

  sl.registerLazySingleton<GetCompletedGoalPercentage>(
    () => GetCompletedGoalPercentage(sl<GoalsRepository>()),
  );

  sl.registerFactory<GoalsCubit>(
    () => GoalsCubit(
      createGoal: sl<CreateGoal>(),
      getAllGoals: sl<GetAllGoals>(),
      markGoalCompleted: sl<MarkGoalCompleted>(),
      updateGoal: sl<UpdateGoal>(),
      deleteGoal: sl<DeleteGoal>(),
      changeGoalType: sl<ChangeGoalType>(),
      getCompletedGoalPercentage: sl<GetCompletedGoalPercentage>(),
    ),
  );

  //
  sl.registerLazySingleton<FriendsRemoteDataSource>(
    () => FriendsRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<FriendsRepository>(
    () =>
        FriendsRepositoryImpl(remoteDataSource: sl<FriendsRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetFriendSuggestions>(
    () => GetFriendSuggestions(sl<FriendsRepository>()),
  );

  sl.registerLazySingleton<AddFriend>(() => AddFriend(sl<FriendsRepository>()));

  sl.registerLazySingleton<SearchFriend>(
    () => SearchFriend(sl<FriendsRepository>()),
  );

  sl.registerLazySingleton<GetFriendRequests>(
    () => GetFriendRequests(sl<FriendsRepository>()),
  );

  sl.registerLazySingleton<AcceptFriendRequest>(
    () => AcceptFriendRequest(sl<FriendsRepository>()),
  );

  sl.registerLazySingleton<RejectFriendRequest>(
    () => RejectFriendRequest(sl<FriendsRepository>()),
  );

  sl.registerLazySingleton<Unfriend>(() => Unfriend(sl<FriendsRepository>()));

  sl.registerLazySingleton<GetAllFriends>(
    () => GetAllFriends(sl<FriendsRepository>()),
  );

  sl.registerFactory<FriendsCubit>(
    () => FriendsCubit(
      getFriendSuggestions: sl<GetFriendSuggestions>(),
      addFriend: sl<AddFriend>(),
      searchFriend: sl<SearchFriend>(),
      getFriendRequests: sl<GetFriendRequests>(),
      acceptFriendRequest: sl<AcceptFriendRequest>(),
      rejectFriendRequest: sl<RejectFriendRequest>(),
      unfriend: sl<Unfriend>(),
      getAllFriends: sl<GetAllFriends>(),
    ),
  );

  // Friends
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () =>
        ProfileRepositoryImpl(remoteDataSource: sl<ProfileRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetUserDetail>(
    () => GetUserDetail(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<CompleteProfile>(
    () => CompleteProfile(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<UpdateProfile>(
    () => UpdateProfile(sl<ProfileRepository>()),
  );

  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getUserDetail: sl<GetUserDetail>(),
      completeProfile: sl<CompleteProfile>(),
      updateProfile: sl<UpdateProfile>(),
    ),
  );
}

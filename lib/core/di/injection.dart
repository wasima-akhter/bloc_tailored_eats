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

  // Goals

  /*
<GoalsRemoteDataSource>

This tells GetIt:

When someone asks me for GoalsRemoteDataSource, give them the registered object.
*/

  sl.registerLazySingleton<GoalsRemoteDataSource>(
    () => GoalsRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<GoalsRepository>(
    () => GoalsRepositoryImpl(remoteDataSource: sl<GoalsRemoteDataSource>()),
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
}

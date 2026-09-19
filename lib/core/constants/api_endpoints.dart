class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String sendEmailOtp = '/auth/send-email-otp';
  static const String checkEmailOtp = '/auth/check-email-otp';
  static const String forgotPassword = '/auth/forget-password';
  static const String checkForgotPasswordOtp =
      '/auth/forget-password-check-otp';
  static const String resetPassword = '/auth/reset-password';

  // User
  static const String userDetail = '/user/user-detail';

  // Consistency
  static const String userConsistencyDetails =
      '/consistency/user-consistency-details';

  // Meal
  static const String getCustomMeal = '/meal/get-custom-meal';
  static const String addCustomMeal = '/meal/add-custom-meal';
  static const String updateCustomMeal = '/meal/update-custom-meal';
  static const String deleteCustomMeal = '/meal/delete-custom-meal';
  static const String ateMeal = '/meal/ate-meal';
  static const String swapMeal = '/meal/swap-meal';
  static const String filterMeal = '/meal/filter-meal';

  // Goal
  static const String createNewGoal = '/goal/create-new-goal';
  static const String getAllGoal = '/goal/get-all-goal';
  static const String markGoalCompleted = '/goal/mark-goal-completed';
  static const String updateGoal = '/goal/update-goal';
  static const String deleteGoal = '/goal/delete-goal';
  static const String changeGoalType = '/goal/change-goal-type';
  static const String completedGoalPercentage =
      '/goal/completed-goal-percentage';

  // Consistency / Weight
  static const String addUserWeight = '/consistency/add-user-weight';
  static const String getUserWeight = '/consistency/get-user-weight';

  // Friend
  static const String getFriendSuggestions = '/friend/get-friend-suggestions';
  static const String addFriend = '/friend/add-friend';
  static const String searchFriend = '/friend/search-friend';
  static const String friendDetail = '/friend/friend-detail';
  static const String getAllFriendRequest = '/friend/get-all-friend-request';
  static const String acceptRequest = '/friend/accept-request';
  static const String rejectRequest = '/friend/reject-request';
  static const String makeUnfriend = '/friend/make-unfriend';
  static const String getAllFriend = '/friend/get-all-friend';

  // Profile
  static const String completeProfile = '/user/complete-profile';
  static const String updateProfile = '/user/update-profile';

  // Settings
  static const String changePassword = '/settings/change-password';
  static const String deleteAccount = '/settings/delete-account';
  static const String getTerms = '/settings/get-terms';
  static const String getPrivacy = '/settings/get-privacy';
  static const String sendSupportEmail = '/settings/send-support-email';
  static const String getSupportEmail = '/settings/get-support-email';
  static const String reportProblem = '/settings/report-problem';
}

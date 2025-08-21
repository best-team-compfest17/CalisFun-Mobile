class Endpoint{
  //auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String forgetPassword = '/auth/change-password';

  //user
  static const String getUserProfile = '/user/profile';

  //child
  static const String leaderboard = '/leaderboard';
  static const String getChildProfile = '/children';
  static const String createChildProfile = '/children/create';
  static const String updateChildProfile = '/children/update';
  static const String deleteChildProfile = '/children/delete';
  static const String getChildOne = '/children/one';

  //reading
  static const String getReading = '/reading/user';
  static const String readingProgress = '/reading/progress';

  //writing
  static const String getWriting = '/writing/user';
  static const String writingProgress = '/writing/progress';

  //counting
  static const String updateCountingDifficulty = '/children/counting-difficulty';
  static const String streakUpdated = '/children/streak';
  static const String stats = '/children/stats';

  //chatbot
  static const String chatbot = '/chat';
}
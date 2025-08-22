import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ChatMode {
  /// Rekomendasi untuk production: Flutter -> Backend kamu -> Azure
  proxyBackend,

  /// Hanya untuk development/testing: Flutter -> Azure langsung (berisiko)
  directAzure,
}

class Endpoint {
  Endpoint._();
  //auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String forgetPassword = '/auth/change-password';
  static const String logout = '/auth/logout';

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
  static const String updateCountingDifficulty =
      '/children/counting-difficulty';
  static const String streakUpdated = '/children/streak';
  static const String stats = '/children/stats';

  //chatbot
  static const String chatbot = '/chat';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get azureEndpoint => dotenv.env['AZURE_OPENAI_ENDPOINT'] ?? '';
  static String get azureApiVersion =>
      dotenv.env['AZURE_API_VERSION'] ?? '2024-06-01';
  static String get azureDeployment =>
      dotenv.env['AZURE_OPENAI_DEPLOYMENT'] ?? '';
  static String get azureApiKey => dotenv.env['AZURE_OPENAI_KEY'] ?? '';

  static ChatMode get chatMode {
    final v = (dotenv.env['CHAT_MODE'] ?? 'proxy').toLowerCase();
    if (v == 'azure') return ChatMode.directAzure;
    return ChatMode.proxyBackend;
  }

  static Uri chatbotProxyUri() {
    if (baseUrl.isEmpty) {
      throw StateError(
        'BASE_URL kosong. Set BASE_URL di .env untuk proxy mode.',
      );
    }
    return Uri.parse('$baseUrl$chatbot');
  }

  static Uri chatbotAzureUri() {
    if (azureEndpoint.isEmpty || azureDeployment.isEmpty) {
      throw StateError(
        'AZURE_OPENAI_ENDPOINT / AZURE_OPENAI_DEPLOYMENT kosong. Isi .env untuk Azure mode.',
      );
    }
    final base =
        azureEndpoint.endsWith('/')
            ? azureEndpoint.substring(0, azureEndpoint.length - 1)
            : azureEndpoint;

    return Uri.parse(
      '$base/openai/deployments/$azureDeployment/chat/completions'
      '?api-version=$azureApiVersion',
    );
  }

  static Uri chatUri() {
    return chatMode == ChatMode.directAzure
        ? chatbotAzureUri()
        : chatbotProxyUri();
  }
}

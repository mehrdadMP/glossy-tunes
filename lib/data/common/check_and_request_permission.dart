import 'package:on_audio_query/on_audio_query.dart';

mixin audioQueryValidator {
  Future<bool> checkAndRequestPermissions(
      {bool retry = false, required OnAudioQuery audioQuery}) async {
    bool hasPermission;
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    return hasPermission;
  }
}

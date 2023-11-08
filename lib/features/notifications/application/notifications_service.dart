import 'package:fcm_config/fcm_config.dart';
import 'cubit/update_device_token_cubit.dart';
import '../../../firebase_options.dart';

class NotificationsService {
  NotificationsService(this._updateDeviceTokenCubit);

  final UpdateDeviceTokenCubit _updateDeviceTokenCubit;

  Future<void> init() async {
    await FCMConfig.instance.init(
      options: DefaultFirebaseOptions.currentPlatform,
      defaultAndroidChannel: const AndroidNotificationChannel(
        'high_importance_channel',
        'Fcm config',
        importance: Importance.high,
      ),
    );

    FCMConfig.instance.messaging.onTokenRefresh.listen((event) {
      _updateDeviceToken(event);
    });
  }

  Future<String?> getDeviceToken() async {
    return await FCMConfig.instance.messaging.getToken();
  }

  Future<void> setDeviceToken() async {
    await FCMConfig.instance.messaging.getToken().then((token) {
      _updateDeviceToken(token);
    });
  }

  void _updateDeviceToken(String? token) {
    if (token != null) {
      _updateDeviceTokenCubit.updateDeviceToken(
        token,
      );
    }
  }
}

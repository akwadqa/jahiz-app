import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/features/notifications/domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel(
      {required super.appMessageId,
      required super.appMessageTitle,
      required super.appMessageIcon,
      required super.publishedOn,
      required super.expiryDate,
      required super.content});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      appMessageId: json['app_message_id'] as String,
      appMessageTitle: json['app_message_title'] as String,
      appMessageIcon: SharedFunctions.getImageUrl(json['app_message_icon']),
      publishedOn: json['published_on'] as String,
      expiryDate: json['expiry_date'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'app_message_id': appMessageId,
        'app_message_title': appMessageTitle,
        'app_message_icon': appMessageIcon,
        'published_on': publishedOn,
        'expiry_date': expiryDate,
        'content': content,
      };
}

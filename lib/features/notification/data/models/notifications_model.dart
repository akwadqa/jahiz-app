import 'package:jahiz/features/notification/domain/entities/notification.dart';

class NotificationModel extends Notifications {
  const NotificationModel(
      {required super.subject,
      required super.emailContent,
      required super.postingDateTime,
      required super.documentType});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        subject: json['subject'],
        emailContent: json['email_content'],
        postingDateTime: json['posting_date_time'],
        documentType: json['document_type'],
        );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject'] = subject;
    map['email_content'] = emailContent;
    map['posting_date_time'] = postingDateTime;
    map['document_type'] = documentType;
    return map;
  }
}

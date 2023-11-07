import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String appMessageId;
  final String appMessageTitle;
  final String appMessageIcon;
  final String publishedOn;
  final String expiryDate;
  final String content;

  const Notification({
    required this.appMessageId,
    required this.appMessageTitle,
    required this.appMessageIcon,
    required this.publishedOn,
    required this.expiryDate,
    required this.content,
  });

  Notification copyWith({
    String? appMessageId,
    String? appMessageTitle,
    String? appMessageIcon,
    String? publishedOn,
    String? expiryDate,
    String? content,
  }) {
    return Notification(
      appMessageId: appMessageId ?? this.appMessageId,
      appMessageTitle: appMessageTitle ?? this.appMessageTitle,
      appMessageIcon: appMessageIcon ?? this.appMessageIcon,
      publishedOn: publishedOn ?? this.publishedOn,
      expiryDate: expiryDate ?? this.expiryDate,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props {
    return [
      appMessageId,
      appMessageTitle,
      appMessageIcon,
      publishedOn,
      expiryDate,
      content,
    ];
  }
}

import 'package:equatable/equatable.dart';

// Todo chnge notification model 
class Notifications extends Equatable {
  final String subject;
  final String emailContent;
  final String postingDateTime;
  final String documentType;


  const Notifications(
      {required this.subject,
      required this.emailContent,
      required this.postingDateTime,
      required this.documentType});


  @override
  List<Object?> get props => [
        subject,
        emailContent,
        postingDateTime,
        documentType
      ];
}

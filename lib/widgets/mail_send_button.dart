import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class MailSendButton extends StatelessWidget {
  const MailSendButton({super.key, required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final Email sendEmail = Email(
          body: 'Test',
          subject: 'Test from app',
          recipients: ['acharya.rujal82@gmail.com', 'ashmit.rajaure@gmail.com', 'anju9chhetri@gmail.com'],
          // cc: ['example_cc@ex.com'],
          // bcc: ['example_bcc@ex.com'],
          attachmentPaths: [imagePath!],
          isHTML: false,
        );

        await FlutterEmailSender.send(sendEmail);
      },
      child: const Icon(Icons.send),
    );
  }
}

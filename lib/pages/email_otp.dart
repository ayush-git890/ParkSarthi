import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailOTP {
  static Future<String> generateOTP(String receiptmail) async {
    String otp = (Random().nextInt(1000000) + 100000).toString();
    String email = "saubhrimohit@gmail.com";
    String pass = "zglp vhcm oetx ikhe";
    final smtpServer = gmail(email, pass);
    final message = Message()
      ..from = Address(email, "ParkSathi")
      ..recipients.add(receiptmail)
      ..subject = "One Time Password"
      ..text = otp;
    try {
      await send(message, smtpServer);
      print("mail send successfully");
    } on MailerException catch (e) {}
    return otp.toString();
  }

  static Future<bool> otpverify(String otp, String userotp) async {
    if (otp == userotp) {
      return true;
    }
    return false;
  }
}

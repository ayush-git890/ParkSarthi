import 'dart:math';
import 'package:ParkSarthi/components/MyTextField.dart';
import 'package:ParkSarthi/components/textwidget.dart';
import 'package:ParkSarthi/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginSignupEmail extends StatefulWidget {
  const LoginSignupEmail({super.key});
  static String email = "";
  static String otp = " ";
  static String userotp = " ";
  static List data = [];
  @override
  State<LoginSignupEmail> createState() => _LoginSignupEmailState();
}

class _LoginSignupEmailState extends State<LoginSignupEmail> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenwidth * 0.05, vertical: 0.1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: screenheight * 0.1,
                ),
                TextWidget(
                  text: "Login or Signup",
                  fontsize: screenwidth * 0.074,
                  fontweight: FontWeight.normal,
                  color: Colors.black,
                ),
                Container(
                  height: screenheight * 0.04,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/ui image.gif",
                    height: screenheight * 0.33,
                    width: screenwidth * 0.85,
                  ),
                ),
                Container(height: screenheight * 0.03),
                TextWidget(
                  text: "Enter Email Address",
                  fontsize: screenwidth * 0.052,
                  fontweight: FontWeight.normal,
                ),
                Container(
                  height: screenheight * 0.02,
                ),
                Form(
                    key: formkey,
                    child: Column(children: [
                      Field(
                        enable: true,
                        controller: emailController,
                        labeltext: "Email",
                        labelcolor: Colors.black,
                        icon: const Icon(Icons.mail),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Enter correct Email";
                          } else {
                            return null;
                          }
                        },
                        onchanged: (value) {
                          LoginSignupEmail.email = value.toString();
                        },
                      ),
                      Container(
                        height: screenheight * 0.02,
                      ),
                    ])),
                Container(
                  height: screenheight * 0.03,
                ),
                GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        Get.to(const EmailVerification());
                        sendotp();
                      }
                    },
                    child: Container(
                      height: screenheight * 0.07,
                      width: screenwidth * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          text: 'Send OTP',
                          fontsize: screenwidth * 0.06,
                          fontweight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Container(
                  height: screenheight * 0.1,
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> sendotp() async {
    if (LoginSignupEmail.email.trim() == "demo@demo.com") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(
          text: "OTP Send Successfully",
        ),
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(10),
        duration: Duration(seconds: 2),
      ));
    } else {
      LoginSignupEmail.otp = Random().nextInt(1000000).toString();
      String email = "saubhrimohit@gmail.com";
      String pass = "zglp vhcm oetx ikhe";
      final smtpServer = gmail(email, pass);
      final message = Message()
        ..from = Address(email, "Stroke Connect")
        ..recipients.add(LoginSignupEmail.email.trim())
        ..subject = "One Time Password"
        ..text = LoginSignupEmail.otp;
      try {
        await send(message, smtpServer).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: TextWidget(
                  text: "OTP Send Successfully",
                ),
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(10),
                duration: Duration(seconds: 2),
              )),
            });
      } on MailerException catch (e) {
        // ignore: use_build_context_synchronously
        QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            text: e.message.toString(),
            onCancelBtnTap: () {
              Navigator.of(context).pop();
            });
      }
    }
  }
}

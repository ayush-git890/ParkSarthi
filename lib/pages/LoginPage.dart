import 'dart:async';
import 'dart:math';
import 'package:ParkSarthi/components/textwidget.dart';
import 'package:ParkSarthi/pages/MapPage.dart';
import 'package:ParkSarthi/pages/lohninscreen.dart';
import 'package:ParkSarthi/pages/splace_page/splace_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);
  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  var code = "";
  bool loading = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int _countdown = 30;
  late Timer _timer;
  void startCountdown() {
    setState(() {
      _countdown = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_countdown > 0) {
        if (mounted) {
          setState(() {
            _countdown--;
          });
        }
      } else {
        setState(() {
          _timer.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return loading
        ? const Splace_Screen()
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: screenheight * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenwidth * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextWidget(
                                text: 'Email Verification',
                                color: Colors.black,
                                fontweight: FontWeight.normal,
                                fontsize: screenwidth * 0.074),
                            Container(
                              height: screenheight * 0.04,
                            ),
                            Row(children: [
                              Expanded(
                                child: TextWidget(
                                    text: 'Enter the code sent to ',
                                    fontsize: screenwidth * 0.055),
                              ),
                            ]),
                            Container(height: screenheight * 0.02),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext builder) =>
                                        const LoginSignupEmail()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextWidget(
                                        text: LoginSignupEmail.email,
                                        fontsize: screenwidth * 0.040),
                                  ),
                                  TextWidget(
                                      text: 'Edit',
                                      color: const Color(0xc654a2a7),
                                      fontsize: screenwidth * 0.055,
                                      fontweight: FontWeight.bold),
                                  const Icon(
                                    Icons.edit,
                                    color: Color(0xc654a2a7),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: screenheight * 0.03),
                            Image.asset(
                              'assets/images/7585aca2-a2f2-4223-aedf-b740e4c18b9f.jpeg',
                              height: screenheight * 0.27,
                              width: screenwidth * 0.8,
                            ),
                            Container(
                              height: screenheight * 0.04,
                            ),
                            //PinCodeTextField  biult-in widget used to create many type of  shape field for Otp and other
                            PinCodeTextField(
                              useExternalAutoFillGroup: true,
                              autoDismissKeyboard: true,
                              autoFocus: true,
                              textInputAction: TextInputAction.done,
                              appContext: context,
                              cursorHeight: 19,
                              onAutoFillDisposeAction:
                                  AutofillContextAction.commit,
                              enablePinAutofill: true,
                              length: 6,
                              keyboardType: TextInputType.number,
                              autoDisposeControllers: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              pinTheme: PinTheme(
                                inactiveFillColor: Colors.blue,
                                inactiveColor: Colors.blue,
                                selectedColor: Colors.blue,
                                activeColor: Colors.blue,
                                selectedFillColor: Colors.blue,
                                disabledColor: Colors.blue,
                                activeFillColor: Colors.blue,
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              // controller: textEditingController1,
                              onChanged: ((value) {
                                LoginSignupEmail.userotp = value;
                                setState(() {});
                              }),
                            ),
                            Container(
                              height: screenheight * 0.03,
                            ),
                            //resend OTP on a cuttent number by throw number variable to Firebase and detect action by onTap property of GestureDector
                            GestureDetector(
                              onTap: () async {
                                if (_countdown == 0) {
                                  LoginSignupEmail.otp =
                                      Random().nextInt(1000000).toString();
                                  String email = "saubhrimohit@gmail.com";
                                  String pass = "zglp vhcm oetx ikhe";
                                  final smtpServer = gmail(email, pass);
                                  final message = Message()
                                    ..from = Address(email, "Stroke Connect")
                                    ..recipients.add(LoginSignupEmail.email
                                        .trim()
                                        .toString())
                                    ..subject = "One Time Password"
                                    ..text = LoginSignupEmail.otp;
                                  try {
                                    await send(message, smtpServer)
                                        .then((value) => {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: TextWidget(
                                                  text:
                                                      "OTP Resend Successfully",
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
                                        text: e.toString(),
                                        onCancelBtnTap: () {
                                          Navigator.of(context).pop();
                                        });
                                  }
                                  startCountdown();
                                }
                              },
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: "Didn't receive code? ",
                                    fontsize: screenwidth * 0.04,
                                  ),
                                  TextWidget(
                                      text: "Resend",
                                      color: _countdown == 0
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontweight: FontWeight.bold,
                                      fontsize: screenwidth * 0.04),
                                  Container(
                                    width: screenwidth * 0.02,
                                  ),
                                  TextWidget(
                                    text: "$_countdown",
                                    color: Colors.red,
                                    fontweight: FontWeight.normal,
                                    fontsize: screenwidth * 0.06,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: screenheight * 0.04,
                            ),
                            // GestureDetector used to make button and detect action by onTap property
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                //to check otp is correct or not
                                if (LoginSignupEmail.otp ==
                                        LoginSignupEmail.userotp ||
                                    LoginSignupEmail.userotp == '123456') {
                                  setState(() {
                                    loading = false;
                                  });
                                  Get.to(const MapPage());
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.warning,
                                      text: 'Incorrect OTP!',
                                      onCancelBtnTap: () {
                                        Navigator.of(context).pop();
                                      });
                                }
                              }
                              //decoration of button verify otp
                              ,
                              child: Container(
                                alignment: Alignment.center,
                                // padding: const EdgeInsets.symmetric(
                                //     vertical: 13, horizontal: 90),
                                height: screenheight * 0.07,
                                width: screenwidth * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextWidget(
                                      text: 'Verify OTP',
                                      fontsize: screenwidth * 0.06,
                                      fontweight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: screenheight * 0.1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )));
  }

  Future<void> sharpref() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var collection1 = FirebaseFirestore.instance.collection('profile');
    // try {
    //   var value = await collection1
    //       .where("gmail", isEqualTo: LoginSignupEmail.email.toString())
    //       .get();
    //   if (value.docs[0].data().isNotEmpty) {
    //     LoginSignupEmail.data.add(value.docs[0].data());
    //     LoginSignupPhone.number = LoginSignupEmail.data[0]["number"];
    //     prefs.setString(GetStarted.lognin, LoginSignupPhone.number);
    //     setState(() {
    //       loading = false;
    //     });
    //     Get.to(const HomePage());
    //   }
    // } catch (e) {
    //   setState(() {
    //     loading = false;
    //   });
    //   Get.to(const EmailRegister());
    // }
  }
}

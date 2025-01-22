import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:product_listing_app_test/utils/color_constants.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';
import 'package:product_listing_app_test/view/home_screen/home_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController pinController = TextEditingController();
  bool isVerifying = false;

  final String staticOtp = "123456";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "OTP Verification",
            style: MytextStyle.headingText,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "OTP VERIFICATION",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: ColorConstants.customGreen,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: MytextStyle.normalText,
                        children: [
                          TextSpan(
                              text:
                                  " Please check your mobile device and enter the OTP below to verify your mobile number.",
                              style: MytextStyle.otpScreen),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Pinput(
                      controller: pinController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    isVerifying
                        ? CircularProgressIndicator()
                        : Container(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(5),
                                backgroundColor: WidgetStateProperty.all(
                                    ColorConstants.customGreen),
                              ),
                              onPressed: () {
                                if (pinController.text == staticOtp) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Invalid OTP"),
                                      backgroundColor:
                                          ColorConstants.customBluee,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Submit',
                                style: MytextStyle.buttonStyle,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_listing_app_test/controller/verify_user_controller/verify_user_controller.dart';
import 'package:product_listing_app_test/utils/color_constants.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';
import 'package:product_listing_app_test/view/Login_screen/widgets/custom_dialogue_box_screen.dart';
import 'package:product_listing_app_test/view/Register_screen/register_screen.dart';
import 'package:product_listing_app_test/view/otp_screen/otp_screen.dart';
import '../../../global_widgets/custom_buttons.dart';
import '../../../global_widgets/custom_textfields.dart';
import 'package:product_listing_app_test/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final verifyUserController =
            Provider.of<VerifyUserController>(context, listen: false);

        final bool? userExists = await verifyUserController.verifyUser(
          phoneNumberController.text.trim(),
        );

        setState(() {
          _isLoading = false;
        });

        if (userExists == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification Successful')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const OtpVerificationScreen()),
          );
        } else if (userExists == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not registered')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not registered')),
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUpWidget();
            },
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey there!", style: MytextStyle.welcome),
                      Text("Welcome Back", style: MytextStyle.welcome),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: phoneNumberController,
                        labelText: "Phone Number",
                        prefixIcon: Image.asset(
                          "assets/images/phone (2).png",
                          scale: 20,
                        ),
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length != 10) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 10),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.customBluee,
                              ),
                            )
                          : Center(
                              child: CustomButton(
                                label: "SUBMIT",
                                textStyle:MytextStyle.buttonStyle,
                                onPressed: _handleSubmit,
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              // Navigate to RegisterScreen
                            },
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: ColorConstants.customGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

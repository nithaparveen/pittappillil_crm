import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/login_screen/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  double scale = 1.0;
  bool isAnimating = false;
  bool isLoginPressed = false;

  void animateButton() {
    if (!isAnimating) {
      setState(() {
        isAnimating = true;
        scale = 0.9;
      });

      Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          scale = 1.0;
          isAnimating = false;
        });
      });
    }
  }

  String? validateEmail(String? value) {
    if (isLoginPressed) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegExp.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (isLoginPressed) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: -120,
              child: Transform.rotate(
                angle: 150,
                child: Container(
                  height: 130,
                  width: 320,
                  decoration: const BoxDecoration(
                    color: Color(0xffffeaea),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      bottomLeft: Radius.circular(90),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 65,
              right: 32,
              child: Container(
                height: 65,
                width: 58,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 220),
                  Text(
                    "Get back to",
                    style: GLTextStyles.montserratStyle(
                      size: 30,
                      weight: FontWeight.w400,
                      color: ColorTheme.pink,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "PACE-X !",
                    style: GLTextStyles.montserratStyle(
                      size: 42,
                      weight: FontWeight.w700,
                      color: ColorTheme.pink,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please Log into your existing account",
                    style: GLTextStyles.robotoStyle(
                      size: 14,
                      weight: FontWeight.w400,
                      color: ColorTheme.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        CustomTextField(
                          width: 307.0,
                          height: 42.0,
                          controller: emailController,
                          hintText: "Email ID",
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 18,
                            color: Color(0xff9c9c9c),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          width: 307.0,
                          height: 42.0,
                          controller: passwordController,
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 18,
                            color: Color(0xff9c9c9c),
                          ),
                          isPasswordField: true,
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 10),
                        AnimatedScale(
                          scale: scale,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: CustomButton(
                            width: 307.0,
                            height: 42.0,
                            text: "Log in",
                            backgroundColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                isLoginPressed = true;
                              });
                              animateButton();
                              Provider.of<LoginController>(context,
                                      listen: false)
                                  .onLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context,
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            const url =
                                'https://crm.pittappillilonline.com/forgot-password';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: GLTextStyles.interStyle(
                              size: 12,
                              weight: FontWeight.w400,
                              color: const Color.fromARGB(255, 142, 142, 142),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

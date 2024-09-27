import 'package:flutter/material.dart';
import 'package:pittappillil_crm/core/constants/colors.dart';
import 'package:pittappillil_crm/core/constants/textstyles.dart';
import 'package:pittappillil_crm/global_widgets/elevated_button.dart';
import 'package:pittappillil_crm/global_widgets/textfield.dart';
import 'package:pittappillil_crm/presentation/login_screen/controller/login_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                          image: AssetImage("assets/logo.png"))),
                )),
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
                      // height: 68 / 39,
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
                      // height: 68 / 39,
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
                      // height: 68 / 39,
                      // letterSpacing: -0.3,
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
                            size: 20,
                            color: Color(0xff9c9c9c),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          width: 307.0,
                          height: 42.0,
                          controller: passwordController,
                          hintText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 20,
                            color: Color(0xff9c9c9c),
                          ),
                          isPasswordField: true,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          width: 307.0,
                          height: 42.0,
                          text: "Log in",
                          onPressed: () {
                            Provider.of<LoginController>(context, listen: false)
                                .onLogin(emailController.text.trim(),
                                    passwordController.text.trim(), context);
                          },
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password ?",
                            style: GLTextStyles.interStyle(
                                size: 12,
                                weight: FontWeight.w400,
                                color: const Color(0xff7f7f7f)),
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

import 'package:flutter/material.dart';
import 'package:taxitaxi_admin/services/admin_service.dart';

import '../helpers/style.dart';
import '../widgets/cab_text_field.dart';
import '../widgets/cab_button.dart';
import '../widgets/cab_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              padding: const EdgeInsets.only(bottom: 20, top: 0),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Hero(
                          tag: "logo-shift",
                          child: Image.asset(
                            "assets/logo-tb.png",
                            height: 280,
                            width: 280,
                          )),
                      const CabText(
                        "SIGN IN",
                        color: Colors.white,
                        size: 20,
                        weight: FontWeight.w300,
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                width: 400,
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CabTextField(
                        controller: emailController,
                        hintText: "EMAIL *",
                        isPassword: false,
                        action: TextInputAction.next,
                        node: emailNode,
                        nextNode: passwordNode,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      CabTextField(
                        controller: passwordController,
                        isPassword: true,
                        node: passwordNode,
                        hintText: "PASSWORD *",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context)
                            //     .pushNamed(ForgotPasswordScreen.routeName);
                          },
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                      height: 1,
                                      fontWeight: FontWeight.w300,
                                      color: primaryColor,
                                      fontSize: 14))),
                        ),
                      ),
                      CabButton(
                          isLoading: isLoading,
                          text: "SIGN IN",
                          func: () async {
                            loginFormKey.currentState!.validate();
                            if (loginFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                AdminService()
                                    .signIn(emailController.text,
                                        passwordController.text, context)
                                    .whenComplete(() => setState(() {
                                          isLoading = false;
                                        }));
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          }),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 24, bottom: 8),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(width: 80, color: Colors.grey, height: 1),
                      //       const CabText(
                      //         "   OR   ",
                      //         size: 14,
                      //       ),
                      //       Container(width: 80, color: Colors.grey, height: 1)
                      //     ],
                      //   ),
                      // ),
                      // Directionality(
                      //   textDirection: TextDirection.rtl,
                      //   child: TextButton.icon(
                      //       onPressed: () => Navigator.of(context)
                      //           .pushReplacementNamed(RegisterScreen.routeName),
                      //       icon: const Icon(
                      //         Icons.arrow_back_ios_rounded,
                      //         size: 20,
                      //         color: Color(0xFF000000),
                      //       ),
                      //       label: const CabText("Create Account")),
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

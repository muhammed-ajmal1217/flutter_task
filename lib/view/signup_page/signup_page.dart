import 'package:flutter/material.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/service/auth_service.dart';
import 'package:task/widgets/main_button.dart';
import 'package:task/widgets/text_field.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLogin;
  SignupPage({super.key, required this.showLogin});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: AppColors.loginBackground,
      ),
      child: Center(
        child: Container(
          height: size.height * 0.80,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 30),
                        ),
                        Text(
                          "Signup with your email and password",
                          style: TextStyle(
                            color: AppColors.mainTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormFieldWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your fullname';
                        }
                        return null;
                      },
                      controller: nameController,
                      hintText: 'Full name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormFieldWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      hintText: 'E-mail',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormFieldWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be 6 charecters';
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormFieldWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be 6 charecters';
                        }
                        return null;
                      },
                      controller: confirPasswordController,
                      hintText: 'Confirm password',
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            AuthService().signupWithEmail(
                                email: emailController.text,
                                password: passwordController.text,
                                userName: nameController.text);
                          }
                        },
                        child: MainButton(
                          size: size,
                          text: 'Sign Up',
                        )),
                  ),
                  Center(
                      child: Text(
                    'Or',
                    style: TextStyle(color: AppColors.mainTextColor),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account?  ',
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                      InkWell(
                          onTap: () => widget.showLogin(),
                          child: Text(
                            'Login',
                            style:
                                TextStyle(color: AppColors.toggleLoginTextColor),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

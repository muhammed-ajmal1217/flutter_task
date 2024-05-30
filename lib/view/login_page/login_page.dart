import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/controller/auth_provider.dart';
import 'package:task/service/auth_service.dart';
import 'package:task/widgets/main_button.dart';
import 'package:task/widgets/text_field.dart';
class LoginPage extends StatefulWidget {
  final VoidCallback showSignUp;
  LoginPage({super.key, required this.showSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.loginBackground,
        ),
        child: Center(
          child: Container(
            height: size.height * 0.70,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Icon(
                    EneftyIcons.lock_2_outline,
                    size: 70,
                    color: AppColors.mainTextColor,
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's begin...",
                          style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 30),
                        ),
                        Text(
                          "Enter your e-mail and password correctly",
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
                      controller: emailController,
                      hintText: 'E-mail',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormFieldWidget(
                      controller: passwordController,
                      hintText: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                           try{
                            Provider.of<AuthProvider>(context,listen: false).signIn(
                              email: emailController.text,
                                password: passwordController.text,
                                context: context
                            );
                           }catch(e){
                            throw Exception('Cant login because : $e');
                           } 
                          }
                        },
                        child: MainButton(
                          size: size,
                          text: 'Login',
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
                        'Create new Account?  ',
                        style: TextStyle(color: AppColors.mainTextColor),
                      ),
                      InkWell(
                          onTap: () => widget.showSignUp(),
                          child: Text(
                            'Sign Up ',
                            style: TextStyle(
                                color: AppColors.toggleLoginTextColor),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

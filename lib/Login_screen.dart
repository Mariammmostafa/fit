import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/CustomTextField/custom_text_field.dart';
import 'package:untitled/Home/HomeView.dart';
import 'package:untitled/Layout/layout.dart';

import 'Register/register.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginscreen";

  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                    delay: const Duration(milliseconds: 50),
                    child: Image.asset(
                      "assets/image/logo.jpg",
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Welcome back To Fitlyft',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 150),
                    child: Text(
                      'Please sign in with your mail',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Email',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 250),
                    child: CustomTextField(
                      controller: emailController,
                      hind: "enter your email",
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please provide your user name";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'Password',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 350),
                    child: CustomTextField(
                        controller: passwordController,
                        hind: "enter your password",
                        maxLines: 1,
                        isPassword: true,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please provide your password";
                          }
                          return null;
                        }),
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 400),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forget password',
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 450),
                    child: MaterialButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) ;
                        {
                          try {
                            // محاولة تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
                            await auth
                                .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )
                                .then((value) {
                              // إذا كانت العملية ناجحة، سيتم توجيه المستخدم إلى الصفحة الرئيسية
                              Navigator.of(context)
                                  .pushReplacementNamed(Layout.routeName);
                            });
                          } on FirebaseAuthException catch (e) {
                            // التعامل مع الأخطاء المترتبة على Firebase، مثل إذا كان المستخدم غير موجود أو كلمة المرور غير صحيحة
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('No user found for that email.')),
                              );
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Wrong password provided for that user.')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Login Failed: ${e.message}')),
                              );
                            }
                          } catch (e) {
                            // التعامل مع الأخطاء العامة
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred: $e')),
                            );
                          }
                        }
                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: mediaQuery.size.width,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            Text("Sign In", style: theme.textTheme.titleMedium),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInRight(
                    delay: const Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: () {
                        // ( context)=> RegisterView();
                        Navigator.of(context).pushNamed(RegisterView.routeName);
                      },
                      child: Text(
                        "Don't have an account ? create Account",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../CustomTextField/custom_text_field.dart';
import '../Layout/layout.dart';

class RegisterView extends StatelessWidget {

  static const String routeName = "RegisterView";
   RegisterView ({super.key});
 // TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth  auth = FirebaseAuth.instance;

  var formkey= GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor:Colors.transparent,
      elevation: 0,
      toolbarHeight: 35,),

      body:Center(
        child:SingleChildScrollView(
          child: Form (
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  delay:const Duration(milliseconds: 50), child:

                Image.asset("assets/image/logo.jpg",height: 100,),
                ),

                const SizedBox(
                  height:30,
                ),






               // FadeInRight(
               //   delay:const Duration(milliseconds: 100),
                //  child:
                //  Text("Full Name",

                 //   style: theme.textTheme.bodyLarge,

              //   ),
              //  ),
                const SizedBox(
                  height:20,
                ),
               // FadeInRight(
              //    delay:const Duration(milliseconds: 150),
               //   child:
                //  CustomTextField(
                 //   controller: fullNameController,
                  //  hind: "enter your full name",
                  //  onValidate: (value) {
                   //   if(value==null || value.trim().isEmpty ) {
                    //    return "please provide full name";
                   //   }
                    //  return null;
                  //  },
                //  ),
             //   ),








                const SizedBox(
                  height:20,
                ),






                FadeInRight(
                  delay:const Duration(milliseconds: 200),
                  child:
                  Text("Email Address",

                    style: theme.textTheme.bodyLarge,

                  ),
                ),
                const SizedBox(
                  height:20,
                ),
                FadeInRight(
                  delay:const Duration(milliseconds: 250),
                  child:
                  CustomTextField(
                    controller: emailController,
                    hind: "enter your email address",
                    onValidate: (value) {
                      if(value==null || value.trim().isEmpty ) {
                        return "please provide email address";
                      }
                      var regex = RegExp(
                          (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));
                          if (!regex.hasMatch(value)){
                            return "invalid email";
                      }

                      return null;

                    },
                  ),
                ),














                const SizedBox(
                  height:20,
                ),
                FadeInRight(
                  delay:const Duration(milliseconds: 300),
                  child:
                  Text('Password',
                    style: theme.textTheme.bodyLarge,

                  ),
                ),
                const SizedBox(
                  height:20,
                ),
                FadeInRight(
                  delay:const Duration(milliseconds: 350),
                  child:
                  CustomTextField(
                      controller: passwordController,
                      hind: "enter your password",
                      maxLines: 1,
                      isPassword: true,
                      onValidate: (value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return "please provide your password";
                        }
                        return null;
                      }
                  ),
                ),





                const SizedBox(
                  height: 30,
                ),
                FadeInRight(
                  delay:const Duration(milliseconds: 400),
                  child:
                  MaterialButton(
                    onPressed:
                      () {
                    if (formkey.currentState!.validate())
                    {
                      auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      ).then((value) {
                        // بعد إنشاء الحساب، تحديث الاسم
                        User? user = value.user;
                        if (user != null) {
                          // تحديث الاسم هنا
                          user.updateProfile(displayName: "اسم المستخدم هنا").then((_) {
                            print("تم تحديث الاسم بنجاح");
                          }).catchError((error) {
                            print("خطأ أثناء تحديث الاسم: $error");
                          });
                        }

                        // التنقل إلى Layout بعد إنشاء الحساب وتحديث الاسم
                        Navigator.of(context).pushReplacementNamed(Layout.routeName);
                      }).catchError((error) {
                        // التعامل مع الأخطاء (مثال: البريد الإلكتروني مستخدم بالفعل)
                        print("Error: $error");
                      });
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
                      child: Text(
                        "Sign Up",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
             //   const SizedBox(
         //         height: 20,
                ),



]

                    ),

                  ),
        ),
      ),

            );





  }
}


// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_strings.dart';
import '../config/app_config.dart';
//import '../helpers/google_auth_helper.dart';
import '../providers/auth_provider.dart';
//import '../providers/google_auth_provider.dart';
//import '../pages/register_page.dart';
import '../pages/home_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgotPasswordPage';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late String tokenVal;

  late String email;

  //var _googleUserDetails;

  @override
  Widget build(BuildContext context) {
    TextEditingController? loginEmailController;
    //TextEditingController loginPasswordController;

    /*  void validateGoogleSubmit() async {
      setState(() {
        isLoading = true;
      });
      try {
        final authDetails = await GoogleAuthHelper.requestGoogleValidation();
        await Provider.of<GoogleAuthProvider>(context, listen: false)
            .authenticateGoogle(authDetails.accessToken);
        tokenVal = await Provider.of<GoogleAuthProvider>(context, listen: false)
            .getToken();

        if (tokenVal.isNotEmpty) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        }
      } catch (error) {
        //print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      }
    } */

    void validateSubmit() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        try {
          await Provider.of<AuthProvider>(context, listen: false)
              .forgotPassword(email);
          setState(() {
            isLoading = false;
          });
          tokenVal = (await Provider.of<AuthProvider>(context, listen: false)
              .getToken())!;
          if (tokenVal.isNotEmpty) {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }
        } catch (error) {
          //print(error);
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text(AppStrings.error),
                  content: Text(error.toString()),
                  actions: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text(AppStrings.close))
                  ],
                );
              });
          setState(() {
            isLoading = false;
          });
        }
      }
    }

    return SafeArea(
      child: (Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: const Text(
              AppStrings.forgotPassword,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppConfig.logoImage,
                          width: 300,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(
                              color: Color(AppConfig.blueColor)),
                          cursorColor: const Color(AppConfig.blueColor),
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: AppStrings.email,
                              icon: const Icon(Icons.email_rounded)),
                          validator: (value) =>
                              value!.isEmpty ? AppStrings.emailValidate : null,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(AppConfig.blueColor),
                                ),
                                onPressed: () => validateSubmit(),
                                child: const Text(
                                  AppStrings.submit,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                      ],
                    )),
              ),
            ),
          ))),
    );
  }
}

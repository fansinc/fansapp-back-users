import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_strings.dart';
import '../config/app_config.dart';
//import '../helpers/google_auth_helper.dart';
import '../providers/auth_provider.dart';
//import '../providers/google_auth_provider.dart';
//import '../pages/register_page.dart';
import '../pages/home_page.dart';

class EmailAuthPage extends StatefulWidget {
  static const routeName = '/emailAuthPage';

  const EmailAuthPage({Key? key}) : super(key: key);

  @override
  _EmailAuthPageState createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late String tokenVal;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    TextEditingController? loginEmailController;
    TextEditingController? loginPasswordController;

    void validateSubmit() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        try {
          await Provider.of<AuthProvider>(context, listen: false)
              .authenticate(email, password);
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
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
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
        /*  appBar: AppBar(
          backgroundColor: Color(AppConfig.blueColor),
        ), */
        backgroundColor:
            //Colors.black,
            const Color(AppConfig.blackColor),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppConfig.logoImage,
                        // width: 225,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        AppStrings.signIn,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      AppStrings.email,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(AppConfig.grey),
                          border: Border.all(
                              // color: Colors.red,
                              ),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          //Color(AppConfig.blueColor),
                        ),
                        cursorColor: Colors.black,
                        //Color(AppConfig.blueColor),
                        controller: loginEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? AppStrings.emailValidate : null,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      AppStrings.password,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(AppConfig.grey),
                          border: Border.all(
                              // color: Colors.red,
                              ),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          // Color(AppConfig.blueColor),
                        ),
                        cursorColor: Colors.black,
                        controller: loginPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? AppStrings.passwordValidate : null,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.topRight,
                      child: const Text(
                        AppStrings.forgotPassword,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              //Color(AppConfig.greenColor),
                            ),
                            onPressed: () => validateSubmit(),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              child: const Text(
                                AppStrings.signIn,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    /*  const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterPage.routeName);
                      },
                      behavior: HitTestBehavior.opaque,
                      child:
                          /* Container(
                        //alignment: Alignment.center,
                        child: */
                          Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            AppStrings.dontHaveAccount,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            AppStrings.signUp,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      /* RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: AppStrings.dontHaveAccount,
                                //style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: AppStrings.register),
                            ],
                          ),
                        ), */
                    ), */
                    //)
                  ],
                )),
          ),
        ),
      )),
    );
  }
}

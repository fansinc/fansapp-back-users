import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '/pages/email_auth_page.dart';

import '../providers/register_provider.dart';
import '../config/app_strings.dart';
import '../config/app_config.dart';
//import '../pages/auth_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/registerPage';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  String? role;
  //String? dob;
  String? mobile;

  bool? checkVal = false;

/*   TextEditingController nameController;
  TextEditingController emailController; */
  TextEditingController passwordController = TextEditingController();
  //TextEditingController passwordConfirmController;

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmFocusNode = FocusNode();

  void validateSubmit() async {
    // if (_formKey.currentState.validate()) {
    var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) {
      try {
        _formKey.currentState!.save();
        await Provider.of<RegisterProvider>(context, listen: false)
            .registerUser(
                firstName!,
                lastName!,
                //role!,
                email!,
                password!,
                confirmPassword!,
                mobile!);
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(AppStrings.success),
                content: const Text(AppStrings.registrationSuccess),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed(
                          EmailAuthPage.routeName,
                          //AuthPage.routeName
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      icon: const Icon(Icons.close),
                      label: const Text(AppStrings.close))
                ],
              );
            });
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
                        /*  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          AuthPage.routeName); */
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
            backgroundColor: Color(AppConfig.blueColor),
          ), */
        backgroundColor: const Color(AppConfig.blackColor),
        // Colors.black,

        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                        AppStrings.signUp,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      AppStrings.firstName,
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
                        //controller: nameController,
                        style: const TextStyle(
                          color: Colors.black,
                          // Color(AppConfig.blueColor),
                        ),
                        cursorColor: Colors.black,
                        //Color(AppConfig.blueColor),
                        //controller: loginEmailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        //focusNode: firstNameFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return (AppStrings.firstNameValidate);
                          }
                          return null;
                        },
                        /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                        onSaved: (value) {
                          firstName = value!;
                        },
                        //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      AppStrings.lastName,
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
                        //controller: nameController,
                        style: const TextStyle(
                          color: Colors.black,
                          // Color(AppConfig.blueColor),
                        ),
                        cursorColor: Colors.black,
                        //Color(AppConfig.blueColor),
                        //controller: loginEmailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        //focusNode: lastNameFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return (AppStrings.lastNameValidate);
                          }
                          return null;
                        },
                        /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                        onSaved: (value) {
                          lastName = value!;
                        },
                        //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                          // Color(AppConfig.blueColor),
                        ),
                        cursorColor: Colors.black,
                        //Color(AppConfig.blueColor),
                        //controller: loginEmailController,
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
                    const SizedBox(height: 10),
                    const Text(
                      AppStrings.mobile,
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
                        //controller: nameController,
                        style: const TextStyle(
                          color: Colors.black,
                          // Color(AppConfig.blueColor),
                        ),
                        cursorColor: Colors.black,
                        //Color(AppConfig.blueColor),
                        //controller: loginEmailController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        //focusNode: mobileFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return (AppStrings.mobileValidate);
                          }
                          return null;
                        },
                        /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                        onSaved: (value) {
                          mobile = value!;
                        },
                        //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        //Color(AppConfig.blueColor),
                        //controller: loginPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return (AppStrings.passwordValidate);
                          }
                          if (value.isNotEmpty && value.length < 8) {
                            return (AppStrings.passwordLengthValidate);
                          }
                          return null;
                        },
                        /* validator: (value) => value!.isEmpty
                              ? AppStrings.passwordValidate
                              : null, */
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      AppStrings.confirmPassword,
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
                        //Color(AppConfig.blueColor),
                        //controller: loginPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return (AppStrings.passwordValidate);
                          }
                          if (value.isNotEmpty && value.length < 8) {
                            return (AppStrings.passwordLengthValidate);
                          }
                          return null;
                        },
                        /* validator:
                           (value) => value!.isEmpty
                              ? AppStrings.passwordValidate
                              : null, */
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                      ),
                    ),
                    /*  Container(
                        child: */
                    Row(
                      children: [
                        Theme(
                          child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              value: checkVal,
                              activeColor: Colors.white,
                              checkColor: const Color(AppConfig.blueColor),
                              onChanged: (newValue) {
                                setState(() {
                                  checkVal = newValue;
                                });
                              }),
                          data: ThemeData(
                            //primarySwatch: Colors.blue,
                            unselectedWidgetColor: Colors.white, // Your color
                          ),
                        ),
                        /* Checkbox(
                                /* side: BorderSide(
                                  color: Colors.white,
                                ), */
                                value: checkVal,
                                
                                onChanged: (value) {
                                  checkVal = value;
                                }), */
                        const Text(
                          AppStrings.termsConditions1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            decorationColor: Colors.white,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text(
                          AppStrings.termsConditions2,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    //),
                    const SizedBox(height: 10),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
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
                                AppStrings.signUp,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(EmailAuthPage.routeName);
                      },
                      behavior: HitTestBehavior.opaque,
                      child:
                          /* Container(
                          //alignment: Alignment.center,
                          child:  */
                          Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            AppStrings.alreadyHaveAccount,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            AppStrings.login,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //),
                    const SizedBox(height: 10),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

import '/providers/auth_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '/pages/email_auth_page.dart';
import '/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '/config/app_config.dart';
import '/config/app_strings.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profilePage';

  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isInit = true;
  bool isLoading = false;
  //late ProfileModel profile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name;

  late String email;
/*   String? password;
  String? confirmPassword;
  String? role;
  //String? dob; */
  late String mobile;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProfileProvider>(context).fetchSetUserProfile().then((value) {
        //profile = value;
        name = value.fanName;
        email = value.email;
        mobile = value.mobile;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        // print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        /*   Navigator.of(context)
                            .pop(); // Navigate to previous screen */
                        if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(EmailAuthPage.routeName);
                        }
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
    isInit = false;
  }

  void validateSubmit() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();
      await Provider.of<ProfileProvider>(context, listen: false)
          .updateUserProfile(
        name,
        email,
        mobile,
      );
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.profileUpdateSuccess),
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
      //}
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            AppStrings.profilePage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            //color: Color(AppColors.blueColor),
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: Colors.black,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : SingleChildScrollView(
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

                        const Text(
                          AppStrings.name,
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
                            initialValue: name,
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
                            onChanged: (value) {
                              name = value;
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
                            initialValue: email,
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
                            validator: (value) => value!.isEmpty
                                ? AppStrings.emailValidate
                                : null,
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
                            initialValue: mobile,
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
                            onChanged: (value) {
                              mobile = value;
                            },
                            //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                          ),
                        ),
                        const SizedBox(height: 30),

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
                                    AppStrings.submit,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                        //),
                        const SizedBox(height: 10),
                        Center(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              elevation: 10,
                              primary: const Color(AppConfig.orangeColor),
                              /*   shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ), */
                            ),
                            onPressed: () {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .logout();
                              Navigator.pushReplacementNamed(
                                  context, EmailAuthPage.routeName);
                            },
                            icon: const Icon(
                              MdiIcons.logoutVariant,
                              color: Colors.white,
                            ),
                            label: const Text(
                              AppStrings.logout,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        /* SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      /*  const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                        ),
                      ),
                        const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(AppConfig.grey),
                            border: Border.all(
                                // color: Colors.red,
                                ),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: const Text('First Name'),
                      ),*/
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(AppConfig.grey),
                            border: Border.all(
                                // color: Colors.red,
                                ),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: const Text('Name'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(AppConfig.grey),
                            border: Border.all(
                                // color: Colors.red,
                                ),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: const Text('Email'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(AppConfig.grey),
                            border: Border.all(
                                // color: Colors.red,
                                ),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: const Text('Mobile'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(AppConfig.orangeColor),
                              ),
                              onPressed: () {},
                              //=> validateSubmit(),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                child: const Text(
                                  AppStrings.save,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              EmailAuthPage.routeName,
                              (Route<dynamic> route) => false);
                          /* Navigator.pushReplacementNamed(
                      context,
                      EmailAuthPage.routeName,
                      //AuthPage.routeName
                    ); */
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                          child: const Text(
                            AppStrings.signOut,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), */
      ),
    );
  }
}

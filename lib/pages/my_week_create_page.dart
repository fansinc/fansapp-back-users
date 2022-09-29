import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '/pages/my_week_page.dart';
import '/providers/my_week_provider.dart';
import '/providers/asset_provider.dart';
import '/providers/image_picker_provider.dart';

import '/widgets/image_picker_widget.dart';
import 'package:provider/provider.dart';

import '/config/app_strings.dart';

class MyWeekCreatePage extends StatefulWidget {
  static const routeName = '/myWeekCreatePage';
  const MyWeekCreatePage({Key? key}) : super(key: key);

  @override
  State<MyWeekCreatePage> createState() => _MyWeekCreatePageState();
}

class _MyWeekCreatePageState extends State<MyWeekCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? title;
  String? description;
  String? image;

  bool? checkVal = false;

/*   TextEditingController nameController;
  TextEditingController emailController; */
  TextEditingController passwordController = TextEditingController();
  //TextEditingController passwordConfirmController;

  void validateSubmit() async {
    // if (_formKey.currentState.validate()) {
    //var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    //if (valid) {
    try {
      _formKey.currentState!.save();
      final imagePickedFile =
          Provider.of<ImagePickerProvider>(context, listen: false)
              .fetchPickedImage;

      File file = File(imagePickedFile.path);
      // print('File is = ' + file.toString());
      List<int> fileInByte = file.readAsBytesSync();
      String image = base64Encode(fileInByte);
      // image = imagePickedFile.readAsBytes().toString();
      await Provider.of<AssetProvider>(context, listen: false)
          .uploadBase64Image(image)
          .then((uUID) {
        Provider.of<MyWeekProvider>(context, listen: false)
            .createMyWeek(
          2, //change this
          1, //change this
          uUID,
        )
            .then((_) {
          setState(() {
            isLoading = false;
          });
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text(AppStrings.success),
                  content: const Text(AppStrings.myWeekCreationSuccess),
                  actions: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(MyWeekPage.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        icon: const Icon(Icons.close),
                        label: const Text(AppStrings.close))
                  ],
                );
              });
        });
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
    //}
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
            AppStrings.createMyWeek,
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* const Text(
                      AppStrings.newsTitle,
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
                            return (AppStrings.newsTitleValidate);
                          }
                          return null;
                        },
                        /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                        onSaved: (value) {
                          title = value!;
                        },
                        //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      AppStrings.newsDesc,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 200,
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
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.next,
                        //focusNode: lastNameFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return (AppStrings.newsDescValidate);
                          }
                          return null;
                        },
                        /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                        onSaved: (value) {
                          description = value!;
                        },
                        //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                      ),
                    ), */

                    /*  Container(
                        child: */
                    const SizedBox(height: 10),
                    const ImagePickerWidget(),
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
                  ],
                )),
          ),
        ),
      ),
    );
  }
  /*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          AppStrings.newsCreate,
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
      body: Container(),
    );
  } */
}

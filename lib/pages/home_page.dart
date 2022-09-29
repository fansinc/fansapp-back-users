import '/config/app_config.dart';
import '/models/news_model.dart';

import '/config/app_strings.dart';
import '/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/home_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';
import 'email_auth_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;

  List<NewsModel> newsList = [];

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<NewsProvider>(context).fetchSetNews().then((value) {
        newsList = value;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        final errorMsgStr = error.toString();
        String errorMsg, errorTitle;
        if (errorMsgStr.contains('Unauthenticated')) {
          errorMsg = AppStrings.unAuthError;
          errorTitle = AppStrings.alert;
        } else {
          errorMsg = errorMsgStr;
          errorTitle = AppStrings.error;
        }

        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(errorTitle),
                //const Text(AppStrings.error),
                content: Text(errorMsg),
                //Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        //Theme.of(context).primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: isLoading
              ? Container(
                  color: const Color(AppConfig.blackColor),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : HomePageWidget(newsList),
          backgroundColor: const Color(AppConfig.blackColor),
          bottomNavigationBar: const BottomNavBarWidget(0),
        ));
  }
}

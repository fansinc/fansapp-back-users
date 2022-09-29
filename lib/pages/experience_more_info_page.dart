import '/config/app_config.dart';
//import '/models/experiences_model.dart';
import 'package:flutter/material.dart';
import '/widgets/experiences_more_info_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';
//import 'email_auth_page.dart';

class ExperiencesMoreInfoPage extends StatefulWidget {
  static const routeName = '/experiencesMoreInfoPage';

  const ExperiencesMoreInfoPage({Key? key}) : super(key: key);

  @override
  _ExperiencesMoreInfoPageState createState() =>
      _ExperiencesMoreInfoPageState();
}

class _ExperiencesMoreInfoPageState extends State<ExperiencesMoreInfoPage> {
  bool isInit = true;
  bool isLoading = false;

  /*  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ExperiencesProvider>(context)
          .fetchSetExperiences()
          .then((value) {
        experiencesList = value;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pop(); // Navigate to previous screen
                        if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(EmailAuthPage.routeName);
                        }
                      },
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.close))
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
  } */

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final image = args['image'];
    final title = args['title'];
    final desc = args['description'];
    final price = args['price'];
    final playerId = args['player_id'];
    final expId = args['exp_id'];

    return SafeArea(
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            //automaticallyImplyLeading: true,

            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(
              //color: Color(AppColors.blueColor),
              color: Colors.white, //change your color here
            ),
          ),
          body: isLoading
              ? Container(
                  color: const Color(AppConfig.blackColor),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : ExperiencesMoreInfoPageWidget(
                  image,
                  title,
                  desc,
                  price,
                  playerId,
                  expId,
                ),
          backgroundColor: const Color(AppConfig.blackColor),
          //ExperiencesPageWidget(),
          bottomNavigationBar: const BottomNavBarWidget(2),
        ));
  }
}

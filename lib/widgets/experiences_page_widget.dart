import 'package:cached_network_image/cached_network_image.dart';
import '/config/app_strings.dart';
import '/pages/experiences_create_page.dart';
import '/models/experiences_model.dart';

import '/config/app_config.dart';
import 'package:flutter/material.dart';

import '/widgets/logo_profile_widget.dart';

class ExperiencesPageWidget extends StatefulWidget {
  final List<ExperiencesModel> experiencesList;

  const ExperiencesPageWidget(this.experiencesList, {Key? key})
      : super(key: key);

  @override
  _ExperiencesPageWidgetState createState() => _ExperiencesPageWidgetState();
}

class _ExperiencesPageWidgetState extends State<ExperiencesPageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: const Color(AppConfig.blackColor),
        //Colors.black,
        child: Column(
          children: [
            const LogoProfileWidget(),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.experiences,
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pushNamed(
                            ExperiencesCreatePage.routeName,
                          ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(
                        Icons.create,
                        size: 12,
                        color: Colors.white,
                      ),
                      label: const Text(
                        AppStrings.createExperiences,
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ))
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.experiencesList.length,
                itemBuilder: (context, index) {
                  return
                      /* Container(
                    child: */
                      Column(
                    children: [
                      // Image.asset(AppConfig.logoImage),
                      Container(
                        height: 200,
                        // width: deviceWidth * .92,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.experiencesList[index].image,
                            placeholder: (context, url) => Image.asset(
                              AppConfig.defaultImage,
                              //width: 50,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              AppConfig.defaultImage,
                              // width: 50,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.experiencesList[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.experiencesList[index].description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            '£ ${widget.experiencesList[index].price}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )),
                      /* SizedBox(
                        width: deviceWidth * .90,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                              ExperiencesMoreInfoPage.routeName,
                              arguments: {
                                "image": widget.experiencesList[index].image,
                                "title": widget.experiencesList[index].title,
                                "description":
                                    widget.experiencesList[index].description,
                                "price": widget.experiencesList[index].price,
                                "player_id":
                                    widget.experiencesList[index].playerId,
                                "exp_id": widget.experiencesList[index].id,
                              }),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                          child: const Text(
                            'More Info',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ) */
                    ],
                    // ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

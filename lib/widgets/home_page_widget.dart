import 'package:cached_network_image/cached_network_image.dart';
import '/config/app_strings.dart';
import '/pages/news_create_page.dart';
import '/models/news_model.dart';

import '/config/app_config.dart';

import '/widgets/logo_profile_widget.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  final List<NewsModel> newsList;
  const HomePageWidget(this.newsList, {Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
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
                    AppStrings.latestNews,
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pushNamed(
                            NewsCreatePage.routeName,
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
                        AppStrings.newsCreate,
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
                itemCount: widget.newsList.length,
                itemBuilder: (context, index) {
                  return
                      /* Container(
                    child:  */
                      Column(
                    children: [
                      // Image.asset(AppConfig.logoImage),
                      Container(
                        height: 180,
                        // width: deviceWidth * .92,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.newsList[index].image,
                            //'${_hotelInfoProvData.hotelRoomTypeModel[index].roomTypeImages[indexVal]['links']['full']}${AppStrings.hotelInfoRenderHeight}',
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
                          /* FadeInImage(
                                            placeholder: AssetImage(
                                                AppConfig.defaultImage),
                                            image: NetworkImage(
                                              '${_hotelInfoProvData.hotelRoomTypeModel[index].roomTypeImages[indexVal]['links']['full']}${AppStrings.hotelInfoRenderHeight}',
                                            ),
                                            fit: BoxFit.fill,
                                          ), */
                        ),
                      ),
                      /*  SizedBox(
                          height: 10,
                        ), */
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.newsList[index].title,
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
                          widget.newsList[index].description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
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

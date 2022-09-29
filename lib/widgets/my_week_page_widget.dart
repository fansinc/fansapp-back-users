import 'package:cached_network_image/cached_network_image.dart';
import '/config/app_strings.dart';
import '/pages/my_week_create_page.dart';
import '/models/my_week_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/config/app_config.dart';

import '/widgets/logo_profile_widget.dart';
import 'package:flutter/material.dart';

class MyWeekPageWidget extends StatefulWidget {
  final List<MyWeekModel> myWeekList;
  const MyWeekPageWidget(this.myWeekList, {Key? key}) : super(key: key);

  @override
  _MyWeekPageWidgetState createState() => _MyWeekPageWidgetState();
}

class _MyWeekPageWidgetState extends State<MyWeekPageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
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
                    AppStrings.myWeek,
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pushNamed(
                            MyWeekCreatePage.routeName,
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
                        AppStrings.createMyWeek,
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ))
                ],
              ),
            ),
            /* ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.myWeekList.length,
                itemBuilder: (context, index) {
                  return  */
            widget.myWeekList.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        itemCount: widget.myWeekList.length,
                        //widget.myWeekList[0].image.length,
                        staggeredTileBuilder: (index) =>
                            //const StaggeredTile.extent(2, 1),
                            // StaggeredTile.fit(index.isEven ? 2 : 1),
                            StaggeredTile.count(1, index.isEven ? 1 : 2),
                        mainAxisSpacing: 10.0,
                        //crossAxisSpacing: 300.0,
                        itemBuilder: (ctx, indexVal) {
                          return Container(
                            // width: deviceWidth * .92,
                            margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: widget.myWeekList[indexVal].image[0],
                                placeholder: (context, url) => Image.asset(
                                  AppConfig.defaultImage,
                                  //width: 50,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  AppConfig.defaultImage,
                                  // width: 50,
                                ),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

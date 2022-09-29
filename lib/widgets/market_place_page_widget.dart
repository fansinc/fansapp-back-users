import '/config/app_config.dart';
import '/widgets/logo_profile_widget.dart';

import 'package:flutter/material.dart';

class MarketPlacePageWidget extends StatefulWidget {
  const MarketPlacePageWidget({Key? key}) : super(key: key);

  @override
  _MarketPlacePageWidgetState createState() => _MarketPlacePageWidgetState();
}

class _MarketPlacePageWidgetState extends State<MarketPlacePageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(AppConfig.comingSoonColor),
      //Colors.black,
      child: Column(
        children: [
          const LogoProfileWidget(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(AppConfig.comingSoonImage),
              /*  Text(
                AppStrings.comingSoon,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ) ,*/
            ),
          ),
        ],
      ),
    );
  }
}

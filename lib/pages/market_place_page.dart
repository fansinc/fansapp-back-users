import 'package:flutter/material.dart';

import '/widgets/market_place_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';

class MarketPlacePage extends StatefulWidget {
  static const routeName = '/marketPlacePage';

  const MarketPlacePage({Key? key}) : super(key: key);

  @override
  _MarketPlacePageState createState() => _MarketPlacePageState();
}

class _MarketPlacePageState extends State<MarketPlacePage> {
  @override
  Widget build(BuildContext context) {
    return (const SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: MarketPlacePageWidget(),
          //backgroundColor: Colors.black,
          bottomNavigationBar: BottomNavBarWidget(2),
        )));
  }
}

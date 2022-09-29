import '/pages/experiences_page.dart';
//import '/pages/market_place_page.dart';
import '/pages/my_week_page.dart';
//import '/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/config/app_strings.dart';

//import '../config/app_config.dart';

import '../pages/home_page.dart';

class BottomNavBarWidget extends StatefulWidget {
  final int _loadIndex;
  const BottomNavBarWidget(this._loadIndex, {Key? key}) : super(key: key);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget._loadIndex;
  }

  @override
  Widget build(BuildContext context) {
    void _tabPress(int position) {
      if (position == 0) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else if (position == 1) {
        Navigator.of(context).pushReplacementNamed(MyWeekPage.routeName);
      } else if (position == 2) {
        Navigator.of(context).pushReplacementNamed(ExperiencesPage.routeName);
      }
      /*  else if (position == 2) {
        Navigator.of(context).pushReplacementNamed(MarketPlacePage.routeName);
      } else if (position == 3) {
        Navigator.of(context).pushReplacementNamed(ExperiencesPage.routeName);
      } else if (position == 4) {
        Navigator.of(context).pushReplacementNamed(WalletPage.routeName);
      } */
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 11,
      ),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      onTap: (indexVal) => _tabPress(indexVal),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.calendarMonth,
            //Icons.bookmark_border,
          ),
          label: AppStrings.myWeek,
        ),
        /*  BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.briefcaseOutline,
            //Icons.favorite_border,
          ),
          label: AppStrings.marketPlace,
        ), */
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star_border,
          ),
          label: AppStrings.experiences,
        ),
        /*  BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet_outlined,
          ),
          label: AppStrings.wallet,
        ), */
      ],
    );
    // : BottomAppBar());
  }
}

import 'package:flutter/material.dart';

import '/widgets/wallet_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';

class WalletPage extends StatefulWidget {
  static const routeName = '/walletPage';

  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return (const SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: WalletPageWidget(),
          bottomNavigationBar: BottomNavBarWidget(4),
        )));
  }
}

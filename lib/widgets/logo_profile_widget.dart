import '/pages/profile_page.dart';

import '/config/app_config.dart';
import 'package:flutter/material.dart';

class LogoProfileWidget extends StatelessWidget {
  const LogoProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppConfig.logoImage,
            height: 50,
          ),
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ProfilePage.routeName),
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 30,
              )),
        ],
      ),
    );
  }
}

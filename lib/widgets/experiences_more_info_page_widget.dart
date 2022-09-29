// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import '/config/app_strings.dart';
import '/providers/purchase_provider.dart';
import 'package:provider/provider.dart';

import '/config/app_config.dart';
import 'package:flutter/material.dart';

//import '/widgets/logo_profile_widget.dart';

class ExperiencesMoreInfoPageWidget extends StatefulWidget {
  final image, title, desc, price, playerId, expId;

  const ExperiencesMoreInfoPageWidget(
      this.image, this.title, this.desc, this.price, this.playerId, this.expId,
      {Key? key})
      : super(key: key);

  @override
  _ExperiencesMoreInfoPageWidgetState createState() =>
      _ExperiencesMoreInfoPageWidgetState();
}

class _ExperiencesMoreInfoPageWidgetState
    extends State<ExperiencesMoreInfoPageWidget> {
  bool isLoading = false;

  void purchasExp(playerId, expId, price, userId, statusId) {
    setState(() {
      isLoading = true;
    });
    Provider.of<PurchaseProvider>(
      context,
      listen: false,
    )
        .purchaseExperience(
      playerId,
      expId,
      double.parse(price).toInt(), //change this
      userId,
      statusId,
    )
        .then((_) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.paymentSuccess),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: const Color(AppConfig.blackColor),
        //Colors.black,
        child: Column(
          children: [
            // LogoProfileWidget(),
            /*  Container(
              child:  */
            Column(
              children: [
                // Image.asset(AppConfig.logoImage),
                Container(
                  // width: deviceWidth * .92,
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
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
                /*  SizedBox(
                          height: 10,
                        ), */
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.title,
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
                    widget.desc,
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
                      '£ ${widget.price}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )),

                SizedBox(
                  height: 50,
                  width: deviceWidth * .90,
                  child: ElevatedButton(
                    onPressed: () => purchasExp(
                        widget.playerId, widget.expId, widget.price, 3, 1),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            'Buy Now',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                )
              ],
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

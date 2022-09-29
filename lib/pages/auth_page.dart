/* import 'dart:io';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//import 'package:truverify/pages/linkedin_page.dart';
import '/providers/social_auth_provider.dart';
import '/pages/email_auth_page.dart';

import '../config/app_strings.dart';
import '../config/app_config.dart';
import '../helpers/google_auth_helper.dart';

//import '../providers/google_auth_provider.dart';
import '../pages/register_page.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  static const routeName = '/authPage';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final platform = Platform.isAndroid ? 'Android' : 'iOS';
  bool isLoading = false;
  late String tokenVal;

  late String email;
  late String password;
  var redirectUrl = 'https://hridhamtech.com';
  //'https://truverify.co.uk/';

  var linkedInResult;

  //var _googleUserDetails;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    void validateGoogleSubmit() async {
      setState(() {
        isLoading = true;
      });
      try {
        final authDetails = await GoogleAuthHelper.requestGoogleValidation();
        //final idToken = authDetails.idToken;
        final accessToken = authDetails.accessToken;
        // print(authDetails.idToken);
        await Provider.of<SocialAuthProvider>(context, listen: false)
            .authenticateSocial(
          'google',
          //idToken,
          accessToken,
        )
            .then((_) async {
          tokenVal =
              (await Provider.of<SocialAuthProvider>(context, listen: false)
                  .getToken())!;

          if (tokenVal.isNotEmpty) {
            setState(() {
              isLoading = false;
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });
          }
        });
        //.authenticateGoogle(authDetails.accessToken!);
        /*  tokenVal =
            (await Provider.of<SocialAuthProvider>(context, listen: false)
                .getToken())!;

        if (tokenVal.isNotEmpty) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        } */
      } catch (error) {
        //print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      }
    }

    void validateAppleSubmit() async {
      setState(() {
        isLoading = true;
      });
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.ht.truverify.service',
            redirectUri:
                // For web your redirect URI needs to be the host of the "current page",
                // while for Android you will be using the API server that redirects back into your app via a deep link
                Uri.parse(
              //'intent://callback?${'https://www.truverify.co.uk'}#Intent;package=com.ht.truverify;scheme=signinwithapple;end'
              // ignore: unnecessary_brace_in_string_interps
              //'intent://callback?${}#Intent;package=com.ht.truverify;scheme=signinwithapple;end',
              //'https://truverify.co.uk',
              //'https://example.com/callbacks/sign_in_with_apple',
              'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
            ),
          ),
        );

        /*  print(credential);

        // This is the endpoint that will convert an authorization code obtained
        // via Sign in with Apple into a session in your system
        final signInWithAppleEndpoint = Uri(
          scheme: 'https',
          host: 'flutter-sign-in-with-apple-example.glitch.me',
          //'truverify.co.uk',
          path: '/sign_in_with_apple',
          queryParameters: <String, String>{
            'code': credential.authorizationCode,
            if (credential.givenName != null)
              'firstName': credential.givenName!,
            if (credential.familyName != null)
              'lastName': credential.familyName!,
            'useBundleId': !kIsWeb && (Platform.isIOS || Platform.isMacOS)
                ? 'true'
                : 'false',
            if (credential.state != null) 'state': credential.state!,
          },
        );

        final session = await Client().post(
          signInWithAppleEndpoint,
        );

        // If we got this far, a session based on the Apple ID credential has been created in your system,
        // and you can now set this as the app's session
        // ignore: avoid_print
        print(session); */

        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
        // after they have been validated with Apple (see `Integration` section for more information on how to do this)

        await Provider.of<SocialAuthProvider>(context, listen: false)
            .authenticateSocial(
          'apple',
          credential.identityToken!,
        )
            .then((_) async {
          tokenVal =
              (await Provider.of<SocialAuthProvider>(context, listen: false)
                  .getToken())!;

          if (tokenVal.isNotEmpty) {
            setState(() {
              isLoading = false;
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });
          }
        });
      } catch (error) {
        //print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      }
    }

    void validateLinkedInSubmit() async {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<SocialAuthProvider>(context, listen: false)
            .authenticateSocial(
          'linkedin',
          linkedInResult['token']!,
        )
            .then((_) async {
          tokenVal =
              (await Provider.of<SocialAuthProvider>(context, listen: false)
                  .getToken())!;

          if (tokenVal.isNotEmpty) {
            setState(() {
              isLoading = false;
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });
          }
        });
      } catch (error) {
        //print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      }
    }

    return SafeArea(
        child: (Scaffold(
      backgroundColor: Color(AppConfig.blueColor),
      body: SingleChildScrollView(
        child: Container(
            // margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            //margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
            padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    AppConfig.logoImage,
                    width: 225,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  AppStrings.socialAccounts,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(LinkedInPage.routeName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LinkedInUserWidget(
                          appBar: AppBar(
                            title: Text('LinkedIn'),
                          ),
                          redirectUrl: 'https://www.truverify.com/home',
                          //'https://www.youtube.com/callback',
                          //  redirectUrl,
                          clientId:
                              //'776rnw4e4izlvg',
                              AppConfig.linkedin_client_id,
                          clientSecret:
                              //'rQEgboUHMLcQi59v',
                              AppConfig.linkedin_client_secret,
                          onGetUserProfile: (
                              //LinkedInUserModel
                              linkedInUser) async {
                            Map<String, dynamic> postJson = {
                              "user_id": linkedInUser.user.userId,
                              "email": linkedInUser.user.email!.elements![0]
                                  .handleDeep!.emailAddress,
                              "pic_url": linkedInUser.user.profilePicture,
                              "name": linkedInUser
                                      .user.firstName!.localized!.label! +
                                  ' ' +
                                  linkedInUser.user.lastName!.localized!.label!,
                              "token": linkedInUser.user.token.accessToken,
                              "expires_in": linkedInUser.user.token.expiresIn
                            };
                            setState(() {
                              linkedInResult = postJson;
                            });
                            validateLinkedInSubmit();
                            //Navigator.of(context).pop();
                          },
                          /*  catchError: (error) {
                            print(
                                'Error description: ${error.description} Error code: ${error.statusCode.toString()}');
                          }, */
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SafeArea(
                          child: LinkedInAuthCodeWidget(
                            // destroySession: logoutUser,
                            redirectUrl: 'https://truverify.co.uk/',
                            clientId: AppConfig.linkedin_client_id,
                            onError: (AuthorizationFailedAction e) {
                              print('Error: ${e.toString()}');
                              print('Error: ${e.stackTrace.toString()}');
                              Navigator.pop(context);
                            },
                            onGetAuthCode:
                                (AuthorizationSucceededAction response) {
                              print('Auth code ${response.codeResponse.code}');

                              print('State: ${response.codeResponse.state}');

                              /*  authorizationCode = AuthCodeObject(
                      code: response.codeResponse.code,
                      state: response.codeResponse.state,
                    );
                    setState(() {}); */

                              Navigator.pop(context);
                            },
                          ),
                        ),
                        fullscreenDialog: true,
                      ),
                    ); */
                  },

                  /* var redirectUrl = 'https://truverify.co.uk/';
                    LinkedInUserWidget(
                      redirectUrl: redirectUrl,
                      clientId: AppConfig.linkedin_client_id,
                      clientSecret: AppConfig.linkedin_client_secret,
                      onGetUserProfile: (UserSucceededAction linkedInUser) {
                        print(
                            'Access token ${linkedInUser.user.token.accessToken}');
                        print(
                            'First name: ${linkedInUser.user.firstName!.localized!.label}');
                        print(
                            'Last name: ${linkedInUser.user.lastName!.localized!.label}');
                      },
                      onError: (UserFailedAction e) {
                        print('Error: ${e.toString()}');
                      },
                    ); */

                  child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(AppConfig.grey),
                          border: Border.all(
                              // color: Colors.red,
                              ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            AppConfig.linkedinIconImage,
                            height: 25,
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.linkedin,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(AppConfig.blueColor),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                      /* OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.transparent),
                        ),
                        onPressed: () => validateGoogleSubmit(),
                        icon: Image.asset(
                          AppConfig.linkedinIconImage,
                          height: 30,
                        ),
                        //Icon(Icons.mail),
                        label: Text(
                          AppStrings.linkedin,
                          style: TextStyle(
                            color: Color(AppConfig.blueColor),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )), */
                      ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => validateGoogleSubmit(),
                  child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(AppConfig.grey),
                          border: Border.all(
                              // color: Colors.red,
                              ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            AppConfig.googleIconImage,
                            height: 25,
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.google,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(AppConfig.blueColor),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                      /* OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.transparent),
                        ),
                        onPressed: () => validateGoogleSubmit(),
                        icon: Image.asset(
                          AppConfig.googleIconImage,
                          height: 30,
                        ),
                        //Icon(Icons.mail),
                        label: Text(
                          AppStrings.google,
                          style: TextStyle(
                            color: Color(AppConfig.blueColor),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )), */
                      ),
                ),
                SizedBox(height: 20
                    //platform == 'Android' ? 40 : 20
                    ),
                /* SignInWithAppleButton(
                  style: SignInWithAppleButtonStyle.white,
                  iconAlignment: IconAlignment.left,
                  text: AppStrings.apple,
                  onPressed: () async {
                    final credential =
                        await SignInWithApple.getAppleIDCredential(
                            scopes: [
                          AppleIDAuthorizationScopes.email,
                          AppleIDAuthorizationScopes.fullName,
                        ],
                            webAuthenticationOptions: WebAuthenticationOptions(
                              // Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                              clientId: 'com.ht.truverify.service',

                              redirectUri:
                                  // For web your redirect URI needs to be the host of the "current page",
                                  // while for Android you will be using the API server that redirects back into your app via a deep link
                                  Uri.parse(
                                'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                              ),
                            ));

                    print(credential);

                    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                  },
                ), */
                // Uncomment this
                //if (platform == 'iOS')
                /*  Column(
                  children: [ */
                GestureDetector(
                  onTap: () => validateAppleSubmit(),
                  child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(AppConfig.grey),
                          border: Border.all(
                              // color: Colors.red,
                              ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            AppConfig.appleIconImage,
                            height: 25,
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.apple,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(AppConfig.blueColor),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                      /* OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.transparent),
                            ),
                            onPressed: () => validateGoogleSubmit(),
                            icon: Image.asset(
                              AppConfig.appleIconImage,
                              height: 30,
                            ),
                            //Icon(Icons.mail),
                            label: Text(
                              AppStrings.apple,
                              style: TextStyle(
                                color: Color(AppConfig.blueColor),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )), */
                      ),
                ),
                SizedBox(height: 40),
                /*   ],
                ), */

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: deviceWidth * .33,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      AppStrings.or,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: deviceWidth * .33,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  AppStrings.useYourEmail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                /*  isLoading
                    ? CircularProgressIndicator()
                    :  */
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(AppConfig.greenColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EmailAuthPage.routeName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        AppStrings.login,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                SizedBox(height: 20),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(AppConfig.greenColor)),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterPage.routeName);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        AppStrings.register,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ],
            )),
      ),
    )));
  }
}
 */
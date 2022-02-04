import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task/provider/user_provider.dart';
import 'package:task/res/res.dart';
import 'package:task/router/route_names.dart';
import 'package:task/shared_widgets/custom_long_button.dart';
import 'package:task/utils/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
    // context.read(userProvider).randomNumCreate();
    // await context.read(userProvider).fetchLoginDetails();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Stack(children: [
                Positioned(
                  top: -10,
                  right: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          context.read(userProvider).logout(context: context);
                        },
                        child: Text(
                          "Logout",
                          style: textStyles.kTextSubtitle1
                              .copyWith(color: colors.kColorWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: colors.kColorBlack,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.all(sizes.mediumPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Sizer.vertical48(),
                            const QrCode(),
                          ],
                        ),
                      )),
                  Positioned(
                      top: -20,
                      left: 110,
                      right: 120,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "PLUGIN",
                            style: textStyles.kTextAppBarTitle,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.pagePadding,
                            vertical: sizes.regularPadding),
                      )),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomButton(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.read(userProvider).logout(context: context);
      //   },
      //   child: const Icon(Icons.logout),
      // ),
    );
  }
}

class BottomButton extends ConsumerWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userProvide = watch(userProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: sizes.regularPadding, horizontal: sizes.pagePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: sizes.width - 40,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.lastLogin);
                },
                child: Text(
                  "Last login at ${(userProvide.userSnapDataModel != null && userProvide.userSnapDataModel!.isNotEmpty) ? userProvide.userSnapDataModel![userProvide.userSnapDataModel!.length - 1].lastSignInTime : 'Today'}",
                  style:
                      textStyles.kTextTitle.copyWith(color: colors.kColorWhite),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 0.3, color: colors.kColorWhite),
                ),
              )),
          Sizer.vertical24(),
          CustomLongButton(
              color: colors.kColorLightGrey,
              loading: userProvide.loading,
              label: "SAVE",
              onPress: () {
                context.read(userProvider).uploadQrDetails(context: context);
              })
        ],
      ),
    );
  }
}

class QrCode extends ConsumerWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userProvide = watch(userProvider);
    return SizedBox(
      width: sizes.width,
      child: Column(
        children: [
          Sizer.vertical64(),
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colors.kColorTrimBlack,
                ),
                child: ClipPath(
                  clipper: LinePathClass(),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple),
                  ),
                ),
              ),
              Positioned(
                  bottom: 70,
                  child: SizedBox(
                    width: sizes.width - 40,
                    child: Center(
                      child: Text(
                        "Generated Number",
                        style: textStyles.kTextAppBarTitle.copyWith(
                            color: colors.kColorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: sizes.width - 40,
                    child: Center(
                      child: Text(
                        userProvide.randomNum,
                        style: textStyles.kTextAppBarTitle.copyWith(
                            color: colors.kColorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Positioned(
                top: -70,
                // left: 20,
                // right: 15,
                child: SizedBox(
                  width: sizes.width - 40,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: QrImage(
                          backgroundColor: colors.kColorWhite,
                          padding: EdgeInsets.all(sizes.mediumPadding),
                          data: userProvide.randomNum,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(400, 0);
    path.lineTo(400, 280);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

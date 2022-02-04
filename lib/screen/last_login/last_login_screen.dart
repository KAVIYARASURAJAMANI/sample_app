import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task/models/user_model.dart';
import 'package:task/provider/user_provider.dart';
import 'package:task/res/res.dart';
import 'package:task/shared_widgets/custom_long_button.dart';
import 'package:task/utils/sizer.dart';

import 'last_login_view.dart';
import 'widgets/last_login_card.dart';

class LastLoginScreen extends StatefulWidget {
  const LastLoginScreen({Key? key}) : super(key: key);

  @override
  _LastLoginScreenState createState() => _LastLoginScreenState();
}

class _LastLoginScreenState extends State<LastLoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController lastloginController;

  @override
  void initState() {
    lastloginController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read(lastloginViewProvider).fetchSigninDetails();
    });
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
                Row(
                  children: [
                    SizedBox(
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(sizes.mediumPadding),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: colors.kColorWhite,
                            ),
                          ),
                        )),
                  ],
                ),
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
                      width: sizes.width,
                      decoration: BoxDecoration(
                          color: colors.kColorBlack,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.all(sizes.mediumPadding),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Sizer.vertical20(),
                              LastLogin(
                                tabController: lastloginController,
                              ),
                              SizedBox(
                                height: sizes.height / 1.5,
                                child: LastLoginView(
                                  tabController: lastloginController,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      top: -20,
                      // left: 110,
                      // right: 120,
                      child: SizedBox(
                        width: sizes.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "LAST LOGIN",
                                    style: textStyles.kTextAppBarTitle,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizes.pagePadding,
                                    vertical: sizes.regularPadding),
                              ),
                            ),
                          ],
                        ),
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
          CustomLongButton(
              color: colors.kColorLightGrey,
              loading: userProvide.loading,
              label: "SAVE",
              onPress: () {})
        ],
      ),
    );
  }
}

class LastLogin extends StatefulWidget {
  final TabController tabController;
  const LastLogin({Key? key, required this.tabController}) : super(key: key);

  @override
  _LastLoginState createState() => _LastLoginState();
}

class _LastLoginState extends State<LastLogin>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ScopedReader watch, _) {
      final lastloginProvide = watch(lastloginViewProvider);
      return TabBar(
        controller: widget.tabController,
        // ignore: avoid_bool_literals_in_conditional_expressions
        isScrollable: true,
        labelStyle: textStyles.kTextTabTitle,
        unselectedLabelStyle: textStyles.kTextTitle,
        labelColor: colors.kColorWhite,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: colors.kColorWhite,
        indicatorColor: colors.kColorWhite,
        tabs: lastloginProvide.tabs
            .map((e) => Tab(
                  text: e,
                ))
            .toList(),
      );
    });
  }
}

class LastLoginView extends StatefulWidget {
  final TabController tabController;
  const LastLoginView({Key? key, required this.tabController})
      : super(key: key);

  @override
  _LastLoginViewState createState() => _LastLoginViewState();
}

class _LastLoginViewState extends State<LastLoginView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ScopedReader watch, _) {
      final lastloginProvide = watch(lastloginViewProvider);
      return TabBarView(controller: widget.tabController, children: [
        lastloginProvide.loading
            ? const Center(child: CircularProgressIndicator())
            : TodayLogin(
                data: lastloginProvide.todayList ?? [],
              ),
        lastloginProvide.loading
            ? const Center(child: CircularProgressIndicator())
            : TodayLogin(
                data: lastloginProvide.yesterdaysList ?? [],
              ),
        lastloginProvide.loading
            ? const Center(child: CircularProgressIndicator())
            : TodayLogin(
                data: lastloginProvide.othersList ?? [],
              ),
      ]);
    });
  }
}

class TodayLogin extends StatelessWidget {
  List<UserSnapDataModel> data;
  TodayLogin({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      data.isEmpty
          ? Expanded(
              child: Container(
                  child: Center(
                child: Text(
                  "NO DATA",
                  style: textStyles.kTextSubtitle1
                      .copyWith(color: colors.kColorWhite),
                ),
              )),
            )
          : Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, int i) {
                    return InkWell(
                        child: i == 0
                            ? Column(
                                children: [
                                  Container(
                                    height: 30,
                                  ),
                                  LastLoginCard(data: data[i])
                                ],
                              )
                            : LastLoginCard(data: data[i]));
                  },
                  separatorBuilder: (_, i) => Sizer.vertical42(),
                  itemCount: data.length),
            )
    ]);
  }
}

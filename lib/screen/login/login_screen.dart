import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/provider/user_provider.dart';
import 'package:task/res/res.dart';
import 'package:task/shared_widgets/custom_long_button.dart';
import 'package:task/shared_widgets/custom_text_form_field.dart';
import 'package:task/utils/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    const Login(),
                    Positioned(
                        top: -20,
                        left: 120,
                        right: 120,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: textStyles.kTextAppBarTitle,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: sizes.pagePadding,
                              vertical: sizes.regularPadding),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userProvide = watch(userProvider);
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: colors.kColorBlack,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.all(sizes.mediumPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phone Number",
                style:
                    textStyles.kTextTitle.copyWith(color: colors.kColorWhite),
              ),
              Sizer.vertical16(),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: sizes.mediumPadding),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextFormField(
                    controller: userProvide.phoneNoController,
                    maxCount: 10,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.trim().length == 10) {
                        FocusScope.of(context).unfocus();
                        context
                            .read(userProvider)
                            .verifyPhoneNumber(context: context);
                      }
                    },
                    inputType:
                        const TextInputType.numberWithOptions(signed: true),
                  )),
              Sizer.vertical24(),
              Text(
                "OTP",
                style:
                    textStyles.kTextTitle.copyWith(color: colors.kColorWhite),
              ),
              Sizer.vertical16(),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: sizes.mediumPadding),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomTextFormField(
                    isEnable: userProvide.isOtpEnable,
                    maxCount: 6,
                    controller: userProvide.otpNoController,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.trim().length == 6) {
                        FocusScope.of(context).unfocus();
                        context
                            .read(userProvider)
                            .signinWithAuth(context: context);
                      }
                    },
                    inputType:
                        const TextInputType.numberWithOptions(signed: true),
                  )),
              Sizer.vertical48(),
              CustomLongButton(
                  color: colors.kColorLightGrey,
                  loading: userProvide.loading,
                  label: userProvide.isOtpEnable ? "LOGIN" : "GET OTP",
                  onPress: () {
                    if (userProvide.isOtpEnable) {
                      context
                          .read(userProvider)
                          .signinWithAuth(context: context);
                    } else {
                      context
                          .read(userProvider)
                          .verifyPhoneNumber(context: context);
                    }
                  }),
              Sizer.vertical16(),
            ],
          ),
        ));
  }
}

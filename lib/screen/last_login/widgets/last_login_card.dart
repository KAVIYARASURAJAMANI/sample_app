import 'package:flutter/material.dart';
import 'package:task/models/user_model.dart';
import 'package:task/res/res.dart';

class LastLoginCard extends StatelessWidget {
  UserSnapDataModel data;
  LastLoginCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizes.width,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(overflow: Overflow.visible, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: colors.kColorLightGrey,
                  width: sizes.width,
                  child: Padding(
                    padding: EdgeInsets.all(sizes.regularPadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              data.lastSignInTime.split(',')[1].trim(),
                              style: textStyles.kTextTitle
                                  .copyWith(color: colors.kColorWhite),
                            ),
                          ),
                          Container(
                            child: Text(
                              "IP ${data.ip}",
                              style: textStyles.kTextTitle
                                  .copyWith(color: colors.kColorWhite),
                            ),
                          ),
                          Container(
                            child: Text(
                              data.location,
                              style: textStyles.kTextTitle
                                  .copyWith(color: colors.kColorWhite),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              data.qrImage == null || data.qrImage!.isEmpty
                  ? Container()
                  : Positioned(
                      right: 0,
                      top: -30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            width: 100,
                            height: 100,
                            color: colors.kColorWhite,
                            child: Padding(
                              padding: EdgeInsets.all(sizes.smallPadding),
                              child: Image.network(
                                data.qrImage!,
                                fit: BoxFit.cover,
                              ),
                            )),
                      )),
            ])
          ]),
    );
  }
}

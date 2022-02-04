import 'package:task/res/res.dart';
import 'package:task/shared_widgets/custom_long_button.dart';
import 'package:flutter/material.dart';

final addedSuccessSnackBar = SnackBar(
  content: const Text(
    'Market Watch Scrip added successfully.',
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: colors.kColorGreenButton,
);
final addfailSnackBar = SnackBar(
  content: const Text(
    'Failed to add Scrip. Please retry.',
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: colors.kColorRedButton,
);
final deleteSuccessSnackBar = SnackBar(
  content: const Text(
    'Scrip from Market Watch is deleted successfully.',
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: colors.kColorGreenButton,
);
final deletefailSnackBar = SnackBar(
  content: const Text(
    'Delete is not successful. Please refresh scrip & retry.',
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: colors.kColorRedButton,
);

final mPinErrorSnackBar = SnackBar(
  content: const Text(
    'Wrong mPIN. Please retry.',
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: colors.kColorRedButton,
);

final faErrorSnackBar = SnackBar(
  content: const Text(
    'Wrong 2FA Answers. Please retry.',
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: colors.kColorRedButton,
);

SnackBar errorSnackBar(String error) => SnackBar(
      content: Text(error),
      duration: const Duration(seconds: 1),
      backgroundColor: colors.kColorRedButton,
    );

SnackBar successSnackBar(String success) => SnackBar(
      content: Text(success),
      duration: const Duration(seconds: 1),
      backgroundColor: colors.kColorGreenButton,
    );

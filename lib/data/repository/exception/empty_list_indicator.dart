import 'package:flutter/cupertino.dart';
import 'exception_indicator.dart';

/// Indicates that no items were found.
class EmptyListIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ExceptionIndicator(
        title: 'Something went wrong',
        message: 'Please contact an admin, ',
        assetName: 'assets/emptyBox.png',
      );
}

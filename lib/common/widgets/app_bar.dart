import 'package:flutter/material.dart';
import 'package:ulearning_app/common/widgets/text_widgets.dart';

import '../utils/app_colors.dart';

AppBar buildAppbar({String title = ""}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        height: 1,
      ),
    ),
    title: Text16Normal(
      text: title,
      color: AppColors.primaryText,
    ),
    centerTitle: true,
  );
}

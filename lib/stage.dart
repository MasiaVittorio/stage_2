library stage;

import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sid_ui/sid_ui.dart';
import 'package:sid_bloc/sid_bloc.dart';
import 'resources/all.dart';

export 'package:sid_bloc/sid_bloc.dart';
export 'package:sid_ui/sid_ui.dart';
export 'resources/all.dart';

part 'src/controller/controller.dart';
part 'src/controller/methods.dart';


part 'src/controller/dimensions/controller.dart';
part 'src/controller/dimensions/methods.dart';
part 'src/controller/dimensions/initial_data.dart';

part 'src/controller/pages/controller.dart';
part 'src/controller/pages/methods.dart';
part 'src/controller/pages/initial_data.dart';

part 'src/controller/panel/controller.dart';
part 'src/controller/panel/methods.dart';
part 'src/controller/panel/initial_data.dart';
part 'src/controller/panel/alert/controller.dart';
part 'src/controller/panel/alert/methods.dart';
part 'src/controller/panel/alert/initial_data.dart';
part 'src/controller/panel/snack_bar/controller.dart';
part 'src/controller/panel/snack_bar/methods.dart';

part 'src/controller/pop_behavior/data.dart';

part 'src/controller/theme/controller.dart';
part 'src/controller/theme/methods.dart';
part 'src/controller/theme/initial_data.dart';

part 'src/controller/theme/colors/controller.dart';
part 'src/controller/theme/colors/methods.dart';
part 'src/controller/theme/colors/initial_data.dart';
part 'src/controller/theme/brightness/controller.dart';
part 'src/controller/theme/brightness/methods.dart';
part 'src/controller/theme/brightness/initial_data.dart';
part 'src/controller/theme/derived/controller.dart';
part 'src/controller/theme/derived/methods.dart';



part 'src/models/pages.dart';
part 'src/models/utils.dart';
part 'src/models/top_bar_content.dart';
part 'src/models/top_bar_data.dart';
part 'src/models/dimensions.dart';

part 'src/models/theme/dark_styles.dart';
part 'src/models/theme/themes.dart';
part 'src/models/theme/brightness.dart';
part 'src/models/theme/default_colors.dart';

part 'src/builders/all.dart';
part 'src/builders/main_page.dart';
part 'src/builders/panel_page.dart';
part 'src/builders/open_non_alert.dart';
part 'src/builders/open_non_alert_all_pages.dart';
part 'src/builders/primary_color_brightness.dart';
part 'src/builders/current_color_and_its_brightness.dart';
part 'src/builders/main_pages_data.dart';
part 'src/builders/main_enabled_pages.dart';
part 'src/builders/panel_pages_data.dart';
part 'src/builders/main_and_panel_colors.dart';


part 'src/widget/inherited.dart';
part 'src/widget/main/usable.dart';
part 'src/widget/main/state.dart';
part 'src/widget/main/with_theme.dart';

part 'src/widget/content/widget.dart';
part 'src/widget/content/state.dart';


part 'src/widget/content/components/panel_content.dart';
part 'src/widget/content/components/panel.dart';
part 'src/widget/content/components/bottom_gesture.dart';
part 'src/widget/content/components/panel_extended.dart';
part 'src/widget/content/components/panel_background.dart';
part 'src/widget/content/components/alert_background.dart';
part 'src/widget/content/components/panel_bottom_bar.dart';
part 'src/widget/content/components/panel_collapsed.dart';
part 'src/widget/content/components/bottom_bar.dart';
part 'src/widget/content/components/top_bar.dart';
part 'src/widget/content/components/splash_screen.dart';
part 'src/widget/content/components/snack_bar.dart';




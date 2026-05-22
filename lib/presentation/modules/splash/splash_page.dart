import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:poke_test/helpers/assets_image_helper.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/presentation/modules/splash/controller/splash_controller.dart';
import 'package:poke_test/theme/app_colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        settingsGP.read().onInit(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsGP).state.isDarkMode;

    ref.listen(
      splashProvider,
      callback: (notifier) async {
        final controller = notifier.state;
        if (controller.routeName.isNotEmpty && context.mounted) {
          RouterUtil.pushReplacement(controller.routeName);
        }
      },
    );

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.primaryRed,
      body: Column(
        mainAxisAlignment: .center,
        children: [
          10.h,
          Image(image: AssetImage(AssetsImageHelper.pokeball)),
          Text(
            'Pokémon',
            style: TextStyle(
              fontSize: 55.sp,
              color: Colors.white,
              fontWeight: .w500,
            ),
          ),
          Text(
            'Explorer App',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white.withValues(alpha: .7),
            ),
          ),
          20.h,
          const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
        ],
      ).center.padding(.all(20.sp)),
    );
  }
}

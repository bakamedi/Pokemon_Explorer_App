import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_meedu/consumer/consumer_widget.dart';
import 'package:poke_test/helpers/assets_lottie_helper.dart';
import 'package:poke_test/presentation/globals/controllers/loader/loader_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';

class GlobalLoaderWrapperGW extends StatelessWidget {
  const GlobalLoaderWrapperGW({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final loaderGC = ref.watch(loaderGlobalProvider);

        return Stack(
          alignment: .center,
          children: [
            body,
            loaderGC.loading
                ? PopScope(
                    canPop: false,
                    child: Directionality(
                      textDirection: .ltr,
                      child: Material(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: .blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withValues(alpha: 0.4),
                              ),
                            ),
                            Positioned.fill(
                              top: -15.rh,
                              child: Lottie.asset(
                                AssetsLottieHelper.pokeballLoading,
                                animate: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: 0, height: 0),
          ],
        );
      },
    );
  }
}

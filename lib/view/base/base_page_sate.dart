import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/resources/resources.dart';
import '../../di/di.dart';
import '../../shared/widgets/something/loading.dart';
import 'bloc/common/common_cubit.dart';
import 'bloc/user/user_cubit.dart';

class BasePageState<T extends StatefulWidget, C extends Cubit>
    extends BasePageStateDelegate<T, C> {}

abstract class BasePageStateDelegate<T extends StatefulWidget, C extends Cubit>
    extends State<T> {
  final UserCubit userCubit = getIt.get<UserCubit>();
  final CommonCubit _commonCubit = CommonCubit();
  late C cubit;

  /// use safe area or not
  bool get useSafeArea => true;

  /// this state should use BlocProvider.value or BlocProvicer.create
  bool get useBlocProviderValue => false;

  /// this widget can use loading effect in the future
  bool get isUseLoading => false;

  EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 16);

  void showLoading({bool dismissible = false}) {
    _commonCubit.showLoading(dismissible: dismissible);
  }

  void hideLoading() => _commonCubit.hideLoading();

  @override
  void initState() {
    // if (useBlocProviderValue)
    cubit = getIt.get<C>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _commonCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SafeArea(
          top: useSafeArea,
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                isUseLoading
                    ? Expanded(
                        child: Stack(
                          children: [
                            useBlocProviderValue
                                ? BlocProvider.value(
                                    value: cubit,
                                    child: buildPage(context),
                                  )
                                : BlocProvider(
                                    create: (context) => cubit,
                                    child: buildPage(context),
                                  ),
                            BlocBuilder<CommonCubit, CommonState>(
                              buildWhen: (previous, current) =>
                                  previous.isLoading != current.isLoading,
                              builder: (context, state) {
                                return Stack(
                                  children: [
                                    Visibility(
                                      visible: state.isLoading,
                                      child: ModalBarrier(
                                        color: Colors.black.withOpacity(0.5),
                                        dismissible: state.isdismissible,
                                        barrierSemanticsDismissible:
                                            state.isdismissible,
                                        onDismiss: () {
                                          _commonCubit.hideLoading();
                                        },
                                      ),
                                    ),
                                    if (state.isLoading)
                                      const Center(
                                        child: Loading(),
                                      )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: useBlocProviderValue
                            ? BlocProvider.value(
                                value: cubit,
                                child: buildPage(context),
                              )
                            : BlocProvider(
                                create: (context) => cubit,
                                child: buildPage(context),
                              ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context) => const SizedBox();
}

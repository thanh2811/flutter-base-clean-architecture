// ignore_for_file: use_build_context_synchronously, empty_catches

import 'package:animated_widgets/animated_widgets.dart';
import 'package:base_project/config/config.dart';
import 'package:base_project/config/routes.dart';
import 'package:base_project/data/resources/resources.dart';
import 'package:base_project/shared/etx/app_ext.dart';
import 'package:base_project/shared/utils/validation_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/bloc/auth/auth_bloc.dart';
import '../../../shared/utils/dialog_helper.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/primary_button.dart';
import '../../../shared/widgets/text_field/primary_text_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthBloc authBloc = AuthBloc()..add(AuthInitEvent());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    onLoginPressed() {
      context.showAppDialog(getLoadingDialog());

      final c1 = usernameFormKey.currentState?.validate() ?? false;
      final c2 = passwordFormKey.currentState?.validate() ?? false;
      if (!c1 || !c2) {
        context.pop();
        return;
      }
      authBloc.add(AuthLoginRequestEvent(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      ));
    }

    return BlocProvider<AuthBloc>(
      create: (context) => authBloc,
      lazy: false,
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConfig.defaultPadding,
              ),
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslationAnimatedWidget(
                    enabled: true,
                    duration: const Duration(milliseconds: 1000),
                    values: const [
                      Offset(0, -100), // disabled value value
                      Offset(0, 0), //intermediate value
                      Offset(0, 0) //enabled value
                    ],
                    curve: Curves.slowMiddle,
                    child: OpacityAnimatedWidget.tween(
                      opacityEnabled: 1,
                      opacityDisabled: 0,
                      duration: const Duration(milliseconds: 1200),
                      child: Image.asset(
                        Assets.imAppLogo,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFieldRequiredState) {
                        ViewUtils.toastWarning(
                            'Tên đăng nhập và mật khẩu không được bỏ trống');
                      }
                      if (state is AuthLoadingState) {}
                      if (state is AuthLoginSuccessState) {
                        WidgetsBinding.instance
                            .addPostFrameCallback(((timeStamp) {
                          context.pop();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoute.home,
                            (route) => false,
                          );
                        }));
                      }
                      if (state is AuthLoginFailedState) {
                        context.pop();
                        // context.pop();
                        // ViewUtils.toastWarning(state.message!);
                      }
                      if (state is AuthGetLocalInfoState) {
                        usernameController.text = state.username;
                        passwordController.text = state.password;
                      }
                    },
                    child: const SizedBox(
                      height: 0,
                    ),
                  ),
                  const Text(
                    'Đăng nhập',
                    style: AppTextTheme.textPageTitle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryTextField(
                    label: 'Email',
                    labelStyle: AppTextTheme.textPrimaryBoldMedium,
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    maxLength: 100,
                    formKey: usernameFormKey,
                    validator: ValidationUtils.textEmptyValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (pre, current) =>
                        current is AuthShowPasswordState,
                    builder: (context, state) {
                      if (state is AuthShowPasswordState) {
                        return PrimaryTextField(
                          label: 'Mật khẩu',
                          labelStyle: AppTextTheme.textPrimaryBoldMedium,
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          maxLength: 100,
                          maxLines: 1,
                          obscureText: !state.showPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              authBloc.add(
                                AuthShowPasswordEvent(
                                    showPassword: !state.showPassword),
                              );
                            },
                            icon: Icon(
                              state.showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColor.black,
                            ),
                          ),
                          formKey: passwordFormKey,
                          validator: ValidationUtils.textEmptyValidator,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (pre, current) =>
                              current is AuthRememberState,
                          builder: (context, state) {
                            if (state is AuthRememberState) {
                              return CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  dense: false,
                                  value: state.remember,
                                  onChanged: (value) {
                                    authBloc.add(
                                        AuthRememberEvent(!state.remember));
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  selectedTileColor: Colors.red,
                                  title: const Text(
                                    'Nhớ tài khoản',
                                    style: AppTextTheme.textPrimary,
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                            text: 'Quên mật khẩu?',
                            style: AppTextTheme.textPrimaryBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ForgotPassword()));
                              },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                      context: context,
                      onPressed: onLoginPressed,
                      label: "Đăng Nhập"),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (pre, current) =>
                        current is AuthLoginBySSOLoadingState ||
                        current is AuthLoginBySSOSuccessState ||
                        current is AuthLoginBySSOErrorState,
                    builder: (context, state) {
                      if (state is AuthLoginBySSOLoadingState) {
                        return PrimaryButton(
                            context: context,
                            isLoading: true,
                            onPressed: () => null,
                            label: '');
                      } else {
                        return PrimaryButton(
                          context: context,
                          backgroundColor: AppColor.secondaryColor,
                          onPressed: () {
                            authBloc.add(AuthLoginBySSORequestEvent());
                          },
                          label: "Đăng Nhập Với True Connect",
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

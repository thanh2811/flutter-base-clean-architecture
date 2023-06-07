// ignore_for_file: use_build_context_synchronously, empty_catches
import 'package:base_project/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/resources/colors.dart';
import '../../../shared/bloc/auth/auth_bloc.dart';
import '../../../shared/utils/dialog_helper.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late BuildContext dialogContext;

  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc()..add(AuthInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => _authBloc,
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child:
                // listen state
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColor.primaryBackgroundColor,
                  height: 90,
                  margin: const EdgeInsets.only(top: 70),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/eztek_logo_org.png'),
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
                    if (state is AuthLoadingState) {
                      showDialog(
                        context: context,
                        builder: (context) => getLoadingDialog(),
                        barrierDismissible: false,
                      );
                    }
                    if (state is AuthLoginSuccessState) {
                      WidgetsBinding.instance
                          .addPostFrameCallback(((timeStamp) {
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoute.home,
                          //HomeScreen
                          (route) => false,
                        );
                      }));
                    }
                    if (state is AuthLoginFailedState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ViewUtils.toastWarning(state.message!);
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
                // const Text(
                //   'Đăng nhập',
                //   style: TextStyle(
                //       color: AppColor.titleColor,
                //       fontSize: 30,
                //       fontWeight: FontWeight.w700),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const Text('Email', style: AppTextTheme.textPageTitle),
                // const SizedBox(
                //   height: 8,
                // ),
                // SecondaryTextField(
                //   controller: usernameController,
                //   textInputAction: TextInputAction.next,
                //   fillColor: Colors.transparent,
                //   maxLength: 100,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const Text('Mật khẩu', style: AppTextTheme.textPageTitle),
                // const SizedBox(
                //   height: 8,
                // ),
                // BlocBuilder<AuthBloc, AuthState>(
                //   buildWhen: (pre, current) =>
                //       current is AuthShowPasswordState,
                //   builder: (context, state) {
                //     return SecondaryTextField(
                //       controller: passwordController,
                //       textInputAction: TextInputAction.done,
                //       fillColor: Colors.transparent,
                //       maxLength: 100,
                //       obscureText: _obscureText,
                //       suffixIcon: IconButton(
                //         onPressed: () {
                //           _obscureText = !_obscureText;
                //           _authBloc.add(
                //             AuthShowPasswordEvent(
                //                 showPassword: _obscureText),
                //           );
                //         },
                //         icon: Icon(
                //           _obscureText
                //               ? Icons.visibility
                //               : Icons.visibility_off,
                //           color: AppColor.black,
                //         ),
                //       ),
                //     );
                //   },
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Container(
                //     //   margin: const EdgeInsets.all(3),
                //     //   decoration: BoxDecoration(
                //     //       border: Border.all(width: 3, color: Colors.white)),
                //     //   width: 20,
                //     //   height: 20,
                //     //   child: Checkbox(
                //     //     checkColor: Colors.white,
                //     //     activeColor: AppColor.primaryColor,
                //     //     value: _rememberMe,
                //     //     onChanged: (bool? value) {
                //     //       _rememberMe = value!;
                //     //       _authBloc.add(AuthRememberEvent(_rememberMe));
                //     //     },
                //     //   ),
                //     // ),
                //     // GestureDetector(
                //     //   onTap: () {
                //     //     _rememberMe = !_rememberMe;
                //     //     _authBloc.add(AuthRememberEvent(_rememberMe));
                //     //   },
                //     //   child: const Text(
                //     //     'Nhớ tài khoản',
                //     //     style: TextStyle(
                //     //         color: AppColor.primaryColor, fontSize: 16),
                //     //   ),
                //     // ),
                //     Expanded(
                //       child: BlocBuilder<AuthBloc, AuthState>(
                //         buildWhen: (pre, current) =>
                //             current is AuthRememberState,
                //         builder: (context, state) {
                //           return CheckboxListTile(
                //               controlAffinity:
                //                   ListTileControlAffinity.leading,
                //               dense: false,
                //               value: _rememberMe,
                //               onChanged: (value) {
                //                 _rememberMe = !_rememberMe;
                //                 _authBloc
                //                     .add(AuthRememberEvent(_rememberMe));
                //               },
                //               contentPadding: EdgeInsets.zero,
                //               selectedTileColor: Colors.red,
                //               title: const Text(
                //                 'Nhớ tài khoản',
                //                 style: AppTextTheme.textPrimary,
                //               ));
                //         },
                //       ),
                //     ),
                //
                //     Align(
                //       alignment: Alignment.centerRight,
                //       child: RichText(
                //         text: TextSpan(
                //           text: 'Quên mật khẩu?',
                //           style: AppTextTheme.textPrimaryBlue,
                //           recognizer: TapGestureRecognizer()
                //             ..onTap = () {
                //               // Navigator.push(
                //               //     context,
                //               //     MaterialPageRoute(
                //               //         builder: (context) =>
                //               //             ForgotPassword()));
                //             },
                //         ),
                //       ),
                //     ),
                //
                //   ],
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // PrimaryButton(
                //     context: context,
                //     onPressed: () {
                //       _authBloc.add(AuthRequestEvent(
                //           username: usernameController.text,
                //           password: passwordController.text,
                //           rememberMe: _rememberMe));
                //     },
                //     label: "Đăng Nhập"),
                // const SizedBox(
                //   height: 10,
                // ),
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
                          // backgroundColor: AppColor.secondaryColor,
                          onPressed: () => null,
                          label: '');
                    } else {
                      return PrimaryButton(
                          context: context,
                          // backgroundColor: AppColor.secondaryColor,
                          onPressed: () {
                            _authBloc.add(AuthLoginBySSORequestEvent());
                          },
                          label: "Đăng Nhập Với True Connect");
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
    );
  }
}

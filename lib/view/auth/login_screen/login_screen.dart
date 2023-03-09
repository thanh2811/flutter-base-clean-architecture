// ignore_for_file: use_build_context_synchronously, empty_catches
import 'package:base_project/config/routes.dart';
import 'package:base_project/data/repository/remote/open_id_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/remote/user_repository.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../di/network_injection.dart';
import '../../../shared/utils/dialog_helper.dart';
import '../../../shared/utils/view_utils.dart';
import '../../../shared/widgets/button/primary_button.dart';
import '../../../shared/widgets/text_field/secondary_text_field.dart';
import '../../home_screen/home_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late BuildContext dialogContext;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
        userRepository: getIt.get<UserRepository>(),
        openIDRepository: getIt.get<OpenIDRepository>())
      ..add(LoginInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _loginBloc,
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
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFieldRequiredState) {
                      toastWarning(
                          'Tên đăng nhập và mật khẩu không được bỏ trống');
                    }
                    if (state is LoginLoadingState) {
                      showDialog(
                        context: context,
                        builder: (context) => getLoadingDialog(),
                        barrierDismissible: false,
                      );
                    }
                    if (state is LoginSuccessState) {
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
                    if (state is LoginFailedState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      toastWarning(state.message!);
                    }
                    if (state is LoginGetLocalInfoState) {
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
                // BlocBuilder<LoginBloc, LoginState>(
                //   buildWhen: (pre, current) =>
                //       current is LoginShowPasswordState,
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
                //           _loginBloc.add(
                //             LoginShowPasswordEvent(
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
                //     //       _loginBloc.add(LoginRememberEvent(_rememberMe));
                //     //     },
                //     //   ),
                //     // ),
                //     // GestureDetector(
                //     //   onTap: () {
                //     //     _rememberMe = !_rememberMe;
                //     //     _loginBloc.add(LoginRememberEvent(_rememberMe));
                //     //   },
                //     //   child: const Text(
                //     //     'Nhớ tài khoản',
                //     //     style: TextStyle(
                //     //         color: AppColor.primaryColor, fontSize: 16),
                //     //   ),
                //     // ),
                //     Expanded(
                //       child: BlocBuilder<LoginBloc, LoginState>(
                //         buildWhen: (pre, current) =>
                //             current is LoginRememberState,
                //         builder: (context, state) {
                //           return CheckboxListTile(
                //               controlAffinity:
                //                   ListTileControlAffinity.leading,
                //               dense: false,
                //               value: _rememberMe,
                //               onChanged: (value) {
                //                 _rememberMe = !_rememberMe;
                //                 _loginBloc
                //                     .add(LoginRememberEvent(_rememberMe));
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
                //       _loginBloc.add(LoginRequestEvent(
                //           username: usernameController.text,
                //           password: passwordController.text,
                //           rememberMe: _rememberMe));
                //     },
                //     label: "Đăng Nhập"),
                // const SizedBox(
                //   height: 10,
                // ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (pre, current) =>
                  current is LoginBySSOLoadingState ||
                      current is LoginBySSOSuccessState ||
                      current is LoginBySSOErrorState,
                  builder: (context, state) {
                    if (state is LoginBySSOLoadingState) {
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
                            _loginBloc.add(LoginBySSORequestEvent());
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

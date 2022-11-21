// ignore_for_file: use_build_context_synchronously, empty_catches
import 'dart:isolate';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/user_repository.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../../../di/network_injection.dart';
import '../../../shared/view_utils.dart';
import '../../home_screen/home_screen.dart';
import '../../widgets/loading.dart';
import '../../widgets/primary_button.dart';
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
    _loginBloc = LoginBloc(userRepository: getIt.get<UserRepository>())
      ..add(LoginInitEvent());
  }

  void _showDialog() async {
    WidgetsBinding.instance.addPostFrameCallback(((_) {
      showDialog(
          context: context,
          builder: (dialogContext) {
            dialogContext = context;
            ReceivePort().sendPort;
            return const Loading();
          });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _loginBloc,
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocConsumer<LoginBloc, LoginState>(
                // listen state
                listener: (context, state) {
                  if (state is LoginFieldRequiredState) {
                    toastWarning(
                        'Tên đăng nhập và mật khẩu không được bỏ trống');
                  }
                  if (state is LoginLoadingState) {
                    _showDialog();
                  }
                  if (state is LoginSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()), //HomeScreen
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
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: AppColor.primaryBackgroundColor,
                        height: 90,
                        margin: const EdgeInsets.only(top: 70),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/images/app_slogan.png'),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Đăng nhập',
                        style: TextStyle(
                            color: AppColor.titleColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Email', style: AppTextTheme.textPageTitle),
                      TextField(
                        maxLength: 100,
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        style: AppTextTheme.textPrimary,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryColor),
                          ),
                        ),
                      ),
                      const Text('Mật khẩu', style: AppTextTheme.textPageTitle),
                      TextField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        maxLength: 100,
                        style: AppTextTheme.textPrimary,
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _obscureText = !_obscureText;
                                _loginBloc.add(LoginShowPasswordEvent(
                                    showPassword: _obscureText));
                              },
                              icon: Icon(
                                (state is LoginShowPasswordState)
                                    ? _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off
                                    : _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                color: AppColor.black,
                              ),
                            ),
                            hintStyle: AppTextTheme.textLowPriority),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: Colors.white)),
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: AppColor.primaryColor,
                              value: _rememberMe,
                              onChanged: (bool? value) {
                                _rememberMe = value!;
                                _loginBloc.add(LoginRememberEvent(_rememberMe));
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _rememberMe = !_rememberMe;
                              _loginBloc.add(LoginRememberEvent(_rememberMe));
                            },
                            child: const Text(
                              'Nhớ tài khoản',
                              style: TextStyle(
                                  color: AppColor.primaryColor, fontSize: 16),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              text: TextSpan(
                                text: 'Quên mật khẩu?',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColor.primaryColor,
                                ),
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
                          onPressed: () {
                            _loginBloc.add(LoginRequestEvent(
                                username: usernameController.text,
                                password: passwordController.text,
                                rememberMe: _rememberMe));
                          },
                          label: "Đăng Nhập"),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

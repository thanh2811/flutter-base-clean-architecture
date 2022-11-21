import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repository/user_repository.dart';
import '../../../../data/resources/colors.dart';
import '../../../../di/network_injection.dart';
import '../../../../shared/view_utils.dart';
import '../../login_screen/login_screen.dart';
import 'bloc/new_password_bloc.dart';

class NewPasswordScreen extends StatelessWidget {
  final String skey;
  final String username;
  const NewPasswordScreen(
      {Key? key, required this.skey, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NewPasswordBloc(userRepository: getIt.get<UserRepository>()),
      child: ForgotPasswordUI(
        username: username,
        skey: skey,
      ),
    );
  }
}

class ForgotPasswordUI extends StatefulWidget {
  final String skey;
  final String username;
  const ForgotPasswordUI({Key? key, required this.username, required this.skey})
      : super(key: key);

  @override
  State<ForgotPasswordUI> createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  bool _obscureText1 = true;

  bool _obscureText2 = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryColor.withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.primaryColor,
                  size: 20,
                ))),
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        title: const Center(
          child: Text(
            'Quên mật khẩu',
            style: TextStyle(
              fontSize: 18,
              color: AppColor.textColor,
            ),
          ),
        ),
      ),
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: _obscureText1,
                        controller: passwordController,
                        maxLength: 100,
                        style: const TextStyle(
                            fontSize: 16, color: AppColor.textColor),
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
                                setState(() {
                                  _obscureText1 = !_obscureText1;
                                });
                              },
                              icon: Icon(
                                _obscureText1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: AppColor.primaryColor,
                            ),
                            hintText: 'Nhập mật khẩu mới'),
                      ),
                      TextFormField(
                        obscureText: _obscureText2,
                        controller: confirmPasswordController,
                        maxLength: 100,
                        style: const TextStyle(
                            fontSize: 16, color: AppColor.textColor),
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
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColor.primaryColor,
                          ),
                          hintText: 'Nhập lại mật khẩu mới',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Xác nhận lại mật khẩu.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      BlocListener<NewPasswordBloc, NewPasswordState>(
                        listener: (context, state) {
                          if (state is NewPasswordStateSuccess) {
                            toastSuccess('Đổi mật khẩu thành công.');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (route) => false);
                          } else {
                            toastWarning(
                                'Đổi mật khẩu không thành công vui lòng thử lại.');
                          }
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                context.read<NewPasswordBloc>().add(
                                    NewPasswordEventComplete(
                                        key: widget.skey,
                                        newPassword: passwordController.text,
                                        username: widget.username));
                              }
                            },
                            child: const Text('Hoàn Tất'),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

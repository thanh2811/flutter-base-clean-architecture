import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/auth/forgot_password_method.dart';
import '../../../../data/repository/user_repository.dart';
import '../../../../data/resources/colors.dart';
import '../../../../di/network_injection.dart';
import '../new_password_screen/new_password_screen.dart';
import 'bloc/count_down_bloc/count_down_bloc.dart';
import 'bloc/count_down_bloc/ticker.dart';
import 'bloc/otp_bloc/otp_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String username;
  final ForgotPasswordMethod method;

  const OtpScreen({Key? key, required this.username, required this.method})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpBloc>(
            create: (_) => OtpBloc(userRepository: getIt.get<UserRepository>())
              ..add(OtpEventSend(username: username, method: method))),
        BlocProvider<CountDownBloc>(
            create: (_) => CountDownBloc(ticker: const Ticker()))
      ],
      child: OtpScreenUI(
        username: username,
        method: method,
      ),
    );
  }
}

class OtpScreenUI extends StatelessWidget {
  final String username;
  final ForgotPasswordMethod method;
  OtpScreenUI({Key? key, required this.username, required this.method})
      : super(key: key);
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.select((OtpBloc bloc) => bloc.state) is OtpStateSendSuccess) {
      if (context.select((CountDownBloc bloc) => bloc.state)
              is CountDownStateInit ||
          context.select((CountDownBloc bloc) => bloc.state)
              is CountDownStateExpired) {
        context
            .read<CountDownBloc>()
            .add(const CountDownEventStart(duration: 120));
      } else if (context.select((CountDownBloc bloc) => bloc.state)
          is CountDownStateComplete) {
        context.read<OtpBloc>().add(OtpEventExpired());
        context.read<CountDownBloc>().add(CountDownEventExpired());
      }
    }

    // if(context.select((CountDownBloc bloc) => bloc.state) is CountDownStateComplete) {
    //   context.read<OtpBloc>().add(OtpEventExpired());
    // }

    // if(context.select((CountDownBloc bloc) => bloc.state) is CountDownStateComplete && context.select((OtpBloc bloc) => bloc.state) is OtpStateSendSuccess) {
    //   context.read<OtpBloc>().add(OtpEventOtpExpired());
    // }

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
        title: const Text(
          'Quên mật khẩu',
          style: TextStyle(
            fontSize: 18,
            color: AppColor.textColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Text(
                'Xác Thực Mã OTP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Mã xác thực được gửi qua email của bạn:',
                style: TextStyle(color: AppColor.textColor, fontSize: 14),
              ),
              Text(
                method.value!,
                style:
                    const TextStyle(color: AppColor.primaryColor, fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _textFieldOTP(
                      first: true,
                      last: false,
                      context: context,
                      controller: controller1),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller2),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller3),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller4),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      context: context,
                      controller: controller5),
                  _textFieldOTP(
                      first: false,
                      last: true,
                      context: context,
                      controller: controller6),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  context
                      .select((CountDownBloc bloc) => bloc.state.duration)
                      .toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bạn chưa nhận được mã?',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 14,
                    ),
                  ),
                  BlocBuilder<OtpBloc, OtpState>(builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        context.read<OtpBloc>().add(
                            OtpEventSend(username: username, method: method));
                        // context
                        //     .read<CountDownBloc>()
                        //     .add(const CountDownEventInit(duration: 120));
                      },
                      child: const Text(
                        'Gửi lại OTP',
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocListener<OtpBloc, OtpState>(
                  listener: (context, state) {
                    if (state is OtpStateCheckedSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPasswordScreen(
                                    skey: state.key,
                                    username: username,
                                  )));
                      context.read<OtpBloc>().add(OtpEventInit());
                      context
                          .read<CountDownBloc>()
                          .add(const CountDownEventInit(duration: 120));
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final String otp = controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text +
                            controller5.text +
                            controller6.text;
                        context
                            .read<OtpBloc>()
                            .add(OtpEventCheck(username: username, key: otp));
                      },
                      child: const Text(
                        'Xác Thực OTP',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first,
      required bool last,
      required BuildContext context,
      required TextEditingController controller}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 9,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2 /*, color: Colors.black12*/),
                borderRadius: BorderRadius.circular(0)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(0)),
            errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: AppColor.errorColor),
                borderRadius: BorderRadius.circular(0)),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

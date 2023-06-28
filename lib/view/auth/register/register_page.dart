import '../../../data/resources/resources.dart';
import '../../../shared/widgets/something/primary_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/validation_utils.dart';
import '../../../shared/widgets/text_field/primary_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      appBar: PrimaryAppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        elevation: 0,
        canPop: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Đăng ký tài khoản',
                style: AppTextTheme.textGreeting,
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryTextField(
                label: 'Tài khoản',
                labelStyle: AppTextTheme.textPrimaryBoldMedium,
                controller: emailController,
                textInputAction: TextInputAction.next,
                maxLength: 100,
                formKey: emailFormKey,
                validator: ValidationUtils.emailValidator,
              ),
              const SizedBox(height: 20),
              PrimaryTextField(
                label: 'Mật khẩu',
                labelStyle: AppTextTheme.textPrimaryBoldMedium,
                controller: passwordController,
                textInputAction: TextInputAction.next,
                maxLength: 100,
                formKey: passwordFormKey,
                validator: ValidationUtils.textEmptyValidator,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/presentation/resources/assets_manager.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import 'package:handy_home_app/presentation/resources/style_manager.dart';
import 'package:handy_home_app/presentation/resources/validation_manager.dart';
import 'package:pinput/pinput.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../bussiness logic/authCubit/auth_cubit.dart';
import '../../../bussiness logic/authCubit/auth_state.dart';
import '../../../customwidget/loading_widget.dart';
import '../../../customwidget/snackbar.dart';

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({required this.email, Key? key}) : super(key: key);
  final String email;
  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  late final TextEditingController pinController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImagePath.codeVerificationImage),
              const SizedBox(
                height: 16,
              ),
              Text(
                'توثيق الحساب',
                style: StyleManger.headline1(
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'لقد قمنا بارسال كود تفعيل الى بريدك الالكتروني٬ يرجى ادخال الكود المرسل',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: Pinput(
                  controller: pinController,
                  validator: (value) => value!.isValidOtp,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  autofillHints: const [AutofillHints.oneTimeCode],
                  errorPinTheme: PinTheme(
                      height: 55,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: ColorManager.redDarkColor))),
                  focusedPinTheme: PinTheme(
                      height: 55,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: ColorManager.primaryMainEnableColor))),
                  length: 5,
                  toolbarEnabled: false,
                  defaultPinTheme: PinTheme(
                    height: 55,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyCodeState &&
                      state.verifyCodeStatus ==
                          VerifyCodeStatus.verifySuccess) {
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    NavigationManager.goToAndRemove(RouteConstants.loginRoute);
                  } else if (state is VerifyCodeState &&
                      state.verifyCodeStatus == VerifyCodeStatus.verifyFailed) {
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  } else if (state is VerifyCodeState &&
                      state.verifyCodeStatus ==
                          VerifyCodeStatus.verifyLoading) {
                    showLoading(context);
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<AuthCubit>()
                          .verifyCode(code: pinController.text);
                    }
                  },
                  child: const Text(
                    'تأكيد',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 54)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ResendCodeState &&
                      state.resendCodeStatus == ResendCodeStatus.success) {
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                  } else if (state is ResendCodeState &&
                      state.resendCodeStatus == ResendCodeStatus.failed) {
                    NavigationManager.pop();
                    showSnackBar(context,
                        text: state.message ?? '',
                        backgroundColor: Colors.grey,
                        textColor: Colors.black);
                  } else if (state is ResendCodeState &&
                      state.resendCodeStatus == ResendCodeStatus.loading) {
                    showLoading(context);
                  }
                },
                child: RichTextCustom(
                    text1: 'لم تستلم بريد التفعيل؟ ',
                    text2: 'اضغط هنا',
                    color: ColorManager.brownColor,
                    onPressed: () {
                      context.read<AuthCubit>().resendCode(email: widget.email);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

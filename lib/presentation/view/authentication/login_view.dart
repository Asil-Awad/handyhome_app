import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/bussiness%20logic/authCubit/auth_cubit.dart';
import 'package:handy_home_app/bussiness%20logic/bnbManager/bnb_manager_cubit.dart';
import 'package:handy_home_app/customwidget/loading_widget.dart';
import 'package:handy_home_app/customwidget/richtext_custom.dart';
import 'package:handy_home_app/customwidget/sizedbox_custom.dart';
import 'package:handy_home_app/customwidget/snackbar.dart';
import 'package:handy_home_app/presentation/resources/color_manager.dart';
import '../../../bussiness logic/authCubit/auth_state.dart';
import '../../resources/validation_manager.dart';
import '../../../app/l10n/locale_keys.g.dart';
import '../../../customwidget/button_custom.dart';
import '../../../customwidget/header_custom.dart';
import '../../../customwidget/textformfield_custom.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        children: [
          SvgPicture.asset(
            ImagePath.iconHome,
            width: AppWidthSize.w65,
            height: AppHeightSize.h73,
            alignment: AlignmentDirectional.topStart,
          ),
          HeaderCustom(
            text1: LocaleKeys.loginText.tr(),
            subText: LocaleKeys.subLoginText.tr(),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBoxCustom(
            height: AppHeightSize.h40,
          ),
          CustomTextFormField(
            controller: _emailController,
            text: LocaleKeys.emailText.tr(),
            validator: (value) => value!.isValidEmail,
          ),
          SizedBoxCustom(
            height: AppHeightSize.h16,
          ),
          CustomTextFormField(
            validator: (value) => value!.isValidPassword,
            controller: _passwordController,
            text: LocaleKeys.passwordText.tr(),
            obscureIconEnable: true,
          ),
          SizedBoxCustom(
            height: AppHeightSize.h8,
          ),
          TextButton(
            onPressed: () => NavigationManager.pushNamed(
                RouteConstants.restorePasswordRoute),
            child: Text(
              LocaleKeys.forgetPasswordText.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(decoration: TextDecoration.underline),
            ),
            style: const ButtonStyle(alignment: AlignmentDirectional.topStart),
          ),
          SizedBoxCustom(
            height: AppHeightSize.h24,
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginState &&
                  state.loginCodeStatus == LoginStatus.loggedInSuccessfully) {
                showSnackBar(context,
                    text: state.message ?? '',
                    backgroundColor: Colors.green,
                    textColor: Colors.white);
                context.read<BnbManagerCubit>().onSelectItem(0);
                NavigationManager.goToAndRemove(RouteConstants.homeRoute);
              } else if (state is LoginState &&
                  state.loginCodeStatus == LoginStatus.loggedInFailed) {
                NavigationManager.pop();
                showSnackBar(context,
                    text: state.message ?? '',
                    backgroundColor: Colors.grey,
                    textColor: Colors.black);
              } else if (state is LoginState &&
                  state.loginCodeStatus == LoginStatus.loggedInLoading) {
                showLoading(context);
              }
            },
            child: CustomButtonPrimary(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().login(
                      email: _emailController.text,
                      password: _passwordController.text);
                }
              },
              text: Text(LocaleKeys.loginText.tr()),
            ),
          ),
          SizedBoxCustom(
            height: AppHeightSize.h261,
          ),
          RichTextCustom(
              text1: LocaleKeys.loginFooter1Text.tr(),
              text2: LocaleKeys.loginFooter2Text.tr(),
              color: ColorManager.primaryMainEnableColor,
              onPressed: () =>
                  NavigationManager.pushNamed(RouteConstants.signupRoute)),
          SizedBoxCustom(
            height: AppHeightSize.h35,
          )
        ],
      ),
    ));
  }
}

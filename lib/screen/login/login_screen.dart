import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/config/global_color.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:quanlydiem/screen/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final loginCtl = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => loginCtl.apiState.value == ApiState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đăng Nhập",
                        style: GlobalTextStyles.font24w700ColorWhite
                            .copyWith(color: const Color(0xFF2A4ECA)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Nó trở nên phổ biến vào những năm 1960 với việc phát hành các tờ Letraset có chứa Lorem Ipsum.",
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.font14w400ColorWhite
                            .copyWith(color: const Color(0xFF61677D)),
                      ),
                      const Gap(16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 56.0,
                              decoration: BoxDecoration(
                                  color: GlobalColors.container,
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/ic_fb.png",
                                      height: 24.0, width: 24.0),
                                  const Gap(12.0),
                                  Text(
                                    "Facebook",
                                    style:
                                        GlobalTextStyles.font16w500Color61677D,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(16.0),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 56.0,
                              decoration: BoxDecoration(
                                  color: GlobalColors.container,
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/ic_google.png",
                                      height: 24.0, width: 24.0),
                                  const Gap(12.0),
                                  Text(
                                    "Google",
                                    style:
                                        GlobalTextStyles.font16w500Color61677D,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: const Color(0xFFE0E5EC),
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Hoặc",
                              style: GlobalTextStyles.font14w400Color262626,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: const Color(0xFFE0E5EC),
                          ))
                        ],
                      ),
                      const Gap(20),
                      // Email TextField
                      Container(
                        decoration: BoxDecoration(
                            color: GlobalColors.container,
                            borderRadius: BorderRadius.circular(14.0)),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12),
                            isDense: true,
                            fillColor: GlobalColors.container,
                            hintText: 'Nhập email',
                            hintStyle: GlobalTextStyles.font16w400Color7C8BA0,
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: const Color(0xFF7C8BA0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password TextField
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: GlobalColors.container,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _passwordController,
                          obscureText:
                              !_isPasswordVisible, // Ẩn hoặc hiện mật khẩu
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12),
                            isDense: true,
                            fillColor: GlobalColors.container,
                            hintText: 'Nhập mật khẩu',
                            hintStyle: GlobalTextStyles.font16w400Color7C8BA0,
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFF7C8BA0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFF61677D),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Login Button

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            loginCtl.login(_emailController.text,
                                _passwordController.text, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Đăng nhập',
                            style: GlobalTextStyles.font14w600ColorWhite,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bạn chưa có tài khoản?",
                            style: GlobalTextStyles.font12w400ColorWhite
                                .copyWith(color: Colors.black.withOpacity(.6)),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const RegisterScreen());
                            },
                            child: Text(
                              'Đăng ký',
                              style: GlobalTextStyles.font12w400ColorWhite
                                  .copyWith(color: GlobalColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

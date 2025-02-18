import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/global_color.dart';
import 'package:quanlydiem/config/global_text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Màu nền trắng
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Đăng Ký",
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
                  obscureText: !_isPasswordVisible, // Ẩn hoặc hiện mật khẩu
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
                      color: const Color(0xFF7C8BA0),
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
                  controller: _rePasswordController,
                  obscureText: !_isRePasswordVisible, // Ẩn hoặc hiện mật khẩu
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12),
                    isDense: true,
                    fillColor: GlobalColors.container,
                    hintText: 'Nhập lại mật khẩu',
                    hintStyle: GlobalTextStyles.font16w400Color7C8BA0,
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: const Color(0xFF7C8BA0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isRePasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF61677D),
                      ),
                      onPressed: () {
                        setState(() {
                          _isRePasswordVisible = !_isRePasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Đăng Ký',
                    style: GlobalTextStyles.font14w600ColorWhite,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã có tài khoản?",
                    style: GlobalTextStyles.font12w400ColorWhite
                        .copyWith(color: Colors.black.withOpacity(.6)),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Đăng nhập',
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
    );
  }
}

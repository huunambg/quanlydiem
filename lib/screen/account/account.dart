import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/global_color.dart';
import 'package:quanlydiem/config/global_text_style.dart';
import 'package:quanlydiem/screen/login/controller/login_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:quanlydiem/screen/splash/splash.dart';
import 'package:quanlydiem/util/preferences_util.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({super.key});

  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  final loginCtl = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          const Gap(30.0),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Image.asset(
                "assets/images/logo.png",
                width: w * 0.3,
                height: w * 0.3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(16.0),
          Center(
            child: Obx(
              () => Text(
                loginCtl.userData.value.fullName!,
                style: GlobalTextStyles.font18w700ColorBlack.copyWith(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const Gap(8.0),
          Center(
            child: Obx(
              () => Text(
                loginCtl.userData.value.role == 'Admin'
                    ? "Quản lý nhà hàng"
                    : "Giáo viên dạy học",
                style: GlobalTextStyles.font15w600Color3C3C43.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          const Gap(16.0),
          const Divider(),
          const Gap(16.0),
          loginCtl.userData.value.role == 'Admin'
              ? ItemAccount_OK(
                  iconColor: GlobalColors.primary,
                  icon: Icons.person_2_outlined,
                  onpressed: () {
                    //Get.to(() => const PersonnelAdminScreen());
                  },
                  titile: "Quản lý nhân viên",
                )
              : ItemAccount_OK(
                  iconColor: GlobalColors.primary,
                  icon: Icons.person_2_outlined,
                  onpressed: () {
                    // Get.to(() => UpdateUserScreen(
                    //       user: loginCtl.userData.value,
                    //     ));
                  },
                  titile: "Đổi mật khẩu",
                ),
          loginCtl.userData.value.role == 'Admin'
              ? ItemAccount_OK(
                  iconColor: GlobalColors.primary,
                  icon: Icons.food_bank_outlined,
                  onpressed: () {
                    //     Get.to(() => const BufferAdminScreen());
                  },
                  titile: "Quản lý Buffer",
                )
              : ItemAccount_OK(
                  iconColor: GlobalColors.primary,
                  icon: Icons.bookmark_border,
                  onpressed: () {
                    //  Get.to(() => const BufferAdminScreen());
                  },
                  titile: "Hướng dẫn",
                ),
          loginCtl.userData.value.role == 'Admin'
              ? ItemAccount_OK(
                  iconColor: GlobalColors.primary,
                  icon: Icons.help_center_outlined,
                  onpressed: () {
                    //    Get.to(TransactionStatisticsScreen());
                  },
                  titile: "Thống kê",
                )
              : const SizedBox(),
          ItemAccount_OK(
            iconColor: GlobalColors.primary,
            icon: Icons.lock_outline,
            onpressed: () {
              PanaraConfirmDialog.show(
                context,
                title: "Xin chào",
                message: "Bạn có muốn đăng xuất tài khoản!",
                confirmButtonText: "Đăng xuất",
                cancelButtonText: "Quay lại",
                onTapCancel: () {
                  Get.back();
                },
                onTapConfirm: () {
                  Get.back();
                  Future.delayed(
                    1.seconds,
                    () {
                      PreferencesUtil.clearEmail();
                      PreferencesUtil.clearPassword();
                      Get.offAll(const SplashScreen());
                    },
                  );
                },
                panaraDialogType: PanaraDialogType.warning,
                barrierDismissible: false,
              );
            },
            titile: "Đăng xuất",
          ),
        ],
      ),
    );
  }
}

class ItemAccount_OK extends StatelessWidget {
  const ItemAccount_OK({
    super.key,
    required this.icon,
    required this.onpressed,
    required this.titile,
    this.cardColor = Colors.white,
    this.iconColor = Colors.blue,
    this.textColor = Colors.black87,
    this.trailingColor = Colors.grey,
  });

  final IconData icon;
  final GestureTapCallback onpressed;
  final String titile;
  final Color cardColor;
  final Color iconColor;
  final Color textColor;
  final Color trailingColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: cardColor,
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          onTap: onpressed,
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            titile,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: trailingColor,
          ),
        ),
      ),
    );
  }
}

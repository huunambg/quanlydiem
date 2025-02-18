import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlydiem/config/api_state.dart';
import 'package:quanlydiem/model/class.dart';
import 'package:quanlydiem/screen/classes/controller/home_controller.dart';
import 'package:quanlydiem/screen/home/widget/item_class.dart';
import 'package:quanlydiem/widget/body_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final classesCtl = Get.find<ClassesController>();

  @override
  void initState() {
    super.initState();
    classesCtl.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Theo sinh viên"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                switch (classesCtl.apiState.value) {
                  case ApiState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ApiState.success:
                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: classesCtl.listClass.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        Class classes = classesCtl.listClass[index];
                        return ItemClassCustom(
                          isHome: true,
                          classes: classes,
                        );
                      },
                    );
                  case ApiState.failure:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}

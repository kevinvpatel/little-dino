import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_setting_controller.dart';

class DashboardSettingView extends GetView<DashboardSettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashboardSettingView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DashboardSettingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

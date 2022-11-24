import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_about_us_controller.dart';

class DashboardAboutUsView extends GetView<DashboardAboutUsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashboardAboutUsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DashboardAboutUsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

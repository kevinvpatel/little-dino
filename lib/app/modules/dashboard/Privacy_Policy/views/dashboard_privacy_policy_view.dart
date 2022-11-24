import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_privacy_policy_controller.dart';

class DashboardPrivacyPolicyView
    extends GetView<DashboardPrivacyPolicyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashboardPrivacyPolicyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DashboardPrivacyPolicyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

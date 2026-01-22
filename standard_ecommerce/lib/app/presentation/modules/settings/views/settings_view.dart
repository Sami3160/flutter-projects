import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:standard_ecommerce/app/presentation/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader('General'),
          Obx(
            () => SwitchListTile(
              title: const Text('Notifications'),
              subtitle: const Text('Enable push notifications'),
              value: controller.notificationsEnabled.value,
              onChanged: controller.toggleNotifications,
            ),
          ),
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Enable dark theme'),
              value: controller.darkModeEnabled.value,
              onChanged: controller.toggleDarkMode,
            ),
          ),
          _buildSectionHeader('Account'),
          ListTile(
            title: const Text('Language'),
            subtitle: Obx(() => Text(controller.selectedLanguage.value)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Dummy language selection
              Get.defaultDialog(
                title: 'Select Language',
                content: Column(
                  children: ['English', 'Spanish', 'French']
                      .map(
                        (lang) => ListTile(
                          title: Text(lang),
                          onTap: () {
                            controller.updateLanguage(lang);
                            Get.back();
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Dummy logout
                Get.offAllNamed('/login');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

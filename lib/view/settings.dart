import 'package:flutter/material.dart';
import 'package:praktikum_1/widget/navigation.dart';
import 'package:icons_plus/icons_plus.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("kucingg.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Chioo",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Column(
                  children: [
                    GestureDetector(
                      onTap: null,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: Colors.grey[200],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pengaturan Akun",
                            style: TextStyle(
                              fontSize: 15,
                            ),),
                            Icon(Bootstrap.chevron_right, size: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.grey[200],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pengaturan Akun"),
                          Icon(Bootstrap.chevron_right, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: 2),
    );
  }
}
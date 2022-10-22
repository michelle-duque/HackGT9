import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(shape: const BeveledRectangleBorder(),
      title: const Text('Settings Page'),),
      body: ListView(
        children: const [ListTile(title: Text('Settings page'),)],
      ),
    );
  }
}
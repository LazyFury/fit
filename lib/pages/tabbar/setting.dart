import 'package:flutter/widgets.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Text("Setting"),
    );
  }
}

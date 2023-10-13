
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
            shrinkWrap: false,
            sections: [
              SettingsSection(
                title: Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: Icon(Icons.language),
                    title: Text('Language'),
                    value: Text('English'),
                    onPressed: (context) {

                    },
                  ),
                  SettingsTile.switchTile(
                    onPressed: null,
                    initialValue: false,
                    onToggle: (value) {
                    },
                    leading: Icon(Icons.format_paint),
                    title: Text('Enable custom theme'),
                  ),
                  SettingsTile(title: Text('Default'))
                ],
              ),
              SettingsSection(
                title: Text('Other'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    title: Text('Location'),
                    leading : Icon(Icons.access_time_filled_sharp),
                    value : Text('Vietnam'),
                    onPressed: (context) {},),
                  SettingsTile.navigation(
                    title: Text('Log out'),
                    leading : Icon(Icons.logout),
                    value : Text('Đăng xuất'),
                    onPressed: (context) {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },)
                ],)
            ],
          )

    );
  }

}


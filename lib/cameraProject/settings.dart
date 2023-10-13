
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
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
                  onPressed: (context) {},)
            ],)
        ],
      );
  }

}


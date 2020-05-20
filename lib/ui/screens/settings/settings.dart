import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'languages_screen.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'Common',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LanguagesScreen(),
                      ),
                    );
                  },
                ),
                SettingsTile(
                  title: 'Environment',
                  subtitle: 'Production',
                  leading: Icon(Icons.cloud_queue),
                ),
              ],
            ),
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(
                  title: 'Phone number',
                  leading: Icon(Icons.phone),
                ),
                SettingsTile(
                  title: 'Email',
                  leading: Icon(Icons.email),
                ),
                SettingsTile(
                  title: 'Sign out',
                  leading: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            SettingsSection(
              title: 'Secutiry',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Lock app in background',
                  leading: Icon(Icons.phonelink_lock),
                  switchValue: lockInBackground,
                  onToggle: (bool value) {
                    setState(() {
                      lockInBackground = value;
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: 'Use fingerprint',
                  leading: Icon(Icons.fingerprint),
                  onToggle: (bool value) {},
                  switchValue: false,
                ),
                SettingsTile.switchTile(
                  title: 'Change password',
                  leading: Icon(Icons.lock),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Misc',
              tiles: [
                SettingsTile(
                  title: 'Terms of Service',
                  leading: Icon(Icons.description),
                ),
                SettingsTile(
                  title: 'Open source licenses',
                  leading: Icon(Icons.collections_bookmark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_little_diary/core/themes/app_theme.dart';
import 'package:my_little_diary/logic/settings/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    context.read<SettingsCubit>().loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: AppTheme.lightDisabledColor,
          ),
        ),
        title: const Text('Settings'),
      ),
      body:
          BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
        if (state is SettingsLoaded) {
          return ListView(
            children: [
              SwitchListTile(
                  value: state.settings.password == null, onChanged: (_) {}),
              SwitchListTile(
                  value: state.settings.lightTheme,
                  onChanged: (value) => context
                      .read<SettingsCubit>()
                      .changeTheme(
                          currentSettings: state.settings, lightTheme: value)),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

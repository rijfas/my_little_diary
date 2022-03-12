import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
class Settings {
  @HiveField(0)
  final bool isFirstRun;
  @HiveField(1)
  final bool lightTheme;
  @HiveField(2)
  final String? password;
  Settings({this.isFirstRun = true, this.lightTheme = true, this.password});

  Settings copyWith({
    bool? isFirstRun,
    bool? lightTheme,
    String? password,
  }) {
    return Settings(
      isFirstRun: isFirstRun ?? this.isFirstRun,
      lightTheme: lightTheme ?? this.lightTheme,
      password: password ?? this.password,
    );
  }
}

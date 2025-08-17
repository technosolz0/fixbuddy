import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';

class FRemoteConfig {
  static const String remoteConfigVersionCode = 'currentVersionCode';
  final remoteConfig = FirebaseRemoteConfig.instance;

  /// function to initialize the remote config with `1 minute` fetchTimeout and
  /// `1 day` minimumFetchInterval
  Future initialize() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(days: 1),
      ),
    );

    await remoteConfig.setDefaults(const {remoteConfigVersionCode: '1.0.0'});
  }

  /// function to fetch current version code from Remote Config
  Future<String> getCurrentVersionCode() async {
    bool remoteConfigUpdated = await remoteConfig.fetchAndActivate();
    ServexUtils.dPrint(
      '--->remote_config: Remote Config Updated, fetching version: $remoteConfigUpdated',
    );
    return remoteConfig.getString(remoteConfigVersionCode);
  }
}

/// Created by Rohit Giri on 22/03/23.
class CallAppSettings{
  final String? appId;
  final String? region;
  final String? host;

  CallAppSettings._builder(CallAppSettingBuilder builder):
        appId = builder.appId,
        region = builder.region,
        host = builder.host;
}

class CallAppSettingBuilder {
  String? appId;
  String? region;
  String? host;

  CallAppSettingBuilder();

  CallAppSettings build() {
    return CallAppSettings._builder(this);
  }
}
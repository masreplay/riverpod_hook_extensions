sealed class PlatformData<Android, IOS, Web> {
  const PlatformData();
}

class PlatformAndroid<Android, IOS, Web>
    extends PlatformData<Android, IOS, Web> {
  final Android data;

  const PlatformAndroid(this.data);
}

class PlatformIOS<Android, IOS, Web> extends PlatformData<Android, IOS, Web> {
  final IOS data;

  const PlatformIOS(this.data);
}

class PlatformWeb<Android, IOS, Web> extends PlatformData<Android, IOS, Web> {
  final Web data;

  const PlatformWeb(this.data);
}

sealed class PlatformData<Android, IOS> {
  const PlatformData();
}

class PlatformAndroid<Android, IOS> extends PlatformData<Android, IOS> {
  final Android data;

  const PlatformAndroid(this.data);
}

class PlatformIOS<Android, IOS> extends PlatformData<Android, IOS> {
  final IOS data;

  const PlatformIOS(this.data);
}

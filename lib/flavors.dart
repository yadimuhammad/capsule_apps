enum Flavor {
  production,
  staging,
  dev,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.production:
        return 'Capsule Apps';
      case Flavor.staging:
        return '[staging]Capsule Apps';
      case Flavor.dev:
        return '[dev]Capsule Apps';
    }
  }

}

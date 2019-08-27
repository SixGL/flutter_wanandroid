class Log {
  static void i(dynamic msg) {
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    if (!inProduction) {
      print("SHttp GL = $msg");
    }
  }
}

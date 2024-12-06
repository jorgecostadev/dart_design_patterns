class Mediator {
  final _handlers = <Map<String, dynamic>>[];

  void register({required String eventName, required Function callback}) {
    _handlers.add({'event': eventName, 'callback': callback});
  }

  Future<void> notify({required String eventName, required dynamic callbackData}) async {
    for (final handler in _handlers) {
      if (handler['event'] == eventName) {
        await handler['callback'](callbackData);
      }
    }
  }
}

class ModelFactory {
  Map<Type, Function> _factories = {};

  ModelFactory._();
  static final ModelFactory _instance = new ModelFactory._();

  factory ModelFactory.instance() {
    return _instance;
  }

  ModelFactory registerBuilderMany(Map<Type, Function> map) {
    map.forEach((key, value) {
      registerBuilder(key, value);
    });
    return this;
  }

  ModelFactory registerBuilder(Type t, Function f) {
    if (!_factories.containsKey(t)) {
      _factories[t] = f;
    }

    return this;
  }

  Function resolveBuilder(Type t, [f]) {
    Function builder = f;
    if (builder != null) {
      return builder;
    }

    builder = _factories[t];

    if (builder == null) {
      throw ArgumentError(t.toString() + " builder is not registered");
    }
    return builder;
  }
}

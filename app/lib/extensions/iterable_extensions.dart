extension IteableExtension<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(T e, int i) fun) sync* {
    var index = 0;
    for (final item in this) yield fun(item, index++);
  }
}

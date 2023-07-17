/// Use a [State] class to know when the resource is loading
/// during the stream subscription.
abstract class State<T> {}

class LoadingState<T> implements State<T> {
  const LoadingState();
}

class DataState<T> implements State<T> {
  const DataState(this.data);

  final T data;
}

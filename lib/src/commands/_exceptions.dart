/// An exception that is thrown to indicate that the turtle should stop its
/// current execution.
///
/// This exception is used internally by the flutter_turtle library to control
/// the flow of the turtle's execution. It is caught by the turtle's execution
/// engine and does not propagate to user code.
class StopException implements Exception {}

library flutter_turtle_alias;

import 'flutter_turtle.dart';

mixin _CommandMixIn {}

/// An alias of [Left].
class Lt = Left with _CommandMixIn;

/// An alias of [Right].
class Rt = Right with _CommandMixIn;

/// An alias of [Forward].
class Fd = Forward with _CommandMixIn;

/// An alias of [Back].
class Bk = Back with _CommandMixIn;

/// An alias of [ResetPosition].
class Home = ResetPosition with _CommandMixIn;

/// An alias of [GoTo].
class SetPos = GoTo with _CommandMixIn;

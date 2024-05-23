part of 'bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CheckSession extends SplashEvent {}

class InitializeEvent extends SplashEvent {}

class SimulateProgress extends SplashEvent {}

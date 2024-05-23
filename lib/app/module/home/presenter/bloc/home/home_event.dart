part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadBreeds extends HomeEvent {}

class SearchBreeds extends HomeEvent {
  final String query;

  const SearchBreeds(this.query);

  @override
  List<Object> get props => [query];
}

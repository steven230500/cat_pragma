part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final Model model;
  const HomeState(this.model);

  @override
  List<Object> get props => [
        model,
      ];
}

final class HomeInitial extends HomeState {
  const HomeInitial(super.model);
}

class LoadedState extends HomeState {
  const LoadedState(super.model);
}

class ErrorState extends HomeState {
  const ErrorState(super.model, this.error);
  final Failure error;
}

class Model extends Equatable {
  final List<Breed> breeds;
  final List<Breed> filteredBreeds;

  Model({
    List<Breed>? breeds,
    List<Breed>? filteredBreeds,
  })  : breeds = breeds ?? [],
        filteredBreeds = filteredBreeds ?? [];

  Model copyWith({
    List<Breed>? breeds,
    List<Breed>? filteredBreeds,
  }) {
    return Model(
      breeds: breeds ?? this.breeds,
      filteredBreeds: filteredBreeds ?? this.filteredBreeds,
    );
  }

  @override
  List<Object?> get props {
    return [
      breeds,
      filteredBreeds,
    ];
  }
}

import 'package:cat_pragma/app/module/home/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_pragma/app/core/models/breed.dart';
import 'package:cat_pragma/app/core/models/failure.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeInitial(Model())) {
    on<LoadBreeds>(_onLoadBreeds);
    on<SearchBreeds>(_onSearchBreeds);
  }

  Future<void> _onLoadBreeds(LoadBreeds event, Emitter<HomeState> emit) async {
    final result = await homeRepository.getBreeds();
    result.match(
      (breeds) {
        emit(LoadedState(state.model.copyWith(breeds: breeds, filteredBreeds: breeds)));
      },
      (failure) {
        emit(ErrorState(state.model, Failure(failure.message)));
      },
    );
    await _loadImagesForBreeds(emit);
  }

  Future<void> _loadImagesForBreeds(Emitter<HomeState> emit) async {
    final breeds = state.model.breeds;
    for (final breed in breeds) {
      if (breed.referenceImageId.isNotEmpty) {
        final imageUrlResult = await homeRepository.getImageUrl(breed.referenceImageId);
        imageUrlResult.match(
          (imageUrl) {
            final updatedBreeds = state.model.breeds.map((b) {
              if (b.id == breed.id) {
                return b.copyWith(imageUrl: imageUrl);
              }
              return b;
            }).toList();

            if (!emit.isDone) {
              emit(LoadedState(
                  state.model.copyWith(breeds: updatedBreeds, filteredBreeds: updatedBreeds)));
            }
          },
          (failure) {},
        );
      }
    }
  }

  void _onSearchBreeds(SearchBreeds event, Emitter<HomeState> emit) {
    final filteredBreeds = state.model.breeds.where((breed) {
      return breed.name.toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(LoadedState(state.model.copyWith(filteredBreeds: filteredBreeds)));
  }
}

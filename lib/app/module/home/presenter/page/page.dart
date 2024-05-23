import 'package:cat_pragma/app/module/home/presenter/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<HomeBloc>()..add(LoadBreeds()),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Pragma'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (query) {
                Modular.get<HomeBloc>().add(SearchBreeds(query));
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            return ListView.builder(
              itemCount: state.model.filteredBreeds.length,
              itemBuilder: (context, index) {
                final breed = state.model.filteredBreeds[index];
                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed('/detail', arguments: breed);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ZoomIn(
                          child: CachedNetworkImage(
                            imageUrl: breed.imageUrl,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image_not_supported),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeIn(
                          child: Text(
                            breed.name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 4),
                        FadeIn(
                          child: Text(breed.temperament),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ErrorState) {
            return Center(child: Text('Error: ${state.error.message}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

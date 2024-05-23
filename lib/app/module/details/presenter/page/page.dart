import 'package:flutter/material.dart';
import 'package:cat_pragma/app/core/models/breed.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Breed breed;

  const DetailPage({super.key, required this.breed});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZoomIn(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: breed.imageUrl,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: Text(
                  breed.name,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Chip(
                  label: Text(
                    breed.temperament,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Row(
                  children: [
                    const Icon(Icons.place, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      breed.origin,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Esperanza de vida: ${breed.lifeSpan} años',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: Text(
                  breed.description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 16),
              FadeIn(
                child: Text(
                  'Peso: ${breed.weight}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: GestureDetector(
                  onTap: () {
                    if (breed.wikipediaUrl != null) {
                      _launchURL(breed.wikipediaUrl!);
                    }
                  },
                  child: Text(
                    'Wikipedia: ${breed.wikipediaUrl}',
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Códigos de país: ${breed.countryCodes}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Código de país: ${breed.countryCode}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Grupo de raza: ${breed.breedGroup}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Experimental: ${breed.experimental}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Sin pelo: ${breed.hairless}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Natural: ${breed.natural}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Raro: ${breed.rare}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Rex: ${breed.rex}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Cola suprimida: ${breed.suppressedTail}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Patas cortas: ${breed.shortLegs}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FadeIn(
                child: Text(
                  'Hipoalergénico: ${breed.hypoallergenic}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

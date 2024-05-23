import 'package:oxidized/oxidized.dart';
import 'package:cat_pragma/app/core/http/client.dart';
import 'package:cat_pragma/app/core/models/breed.dart';
import 'package:cat_pragma/app/core/models/failure.dart';

class HomeRepository {
  final Http client;
  HomeRepository({required this.client});

  Future<Result<List<Breed>, Failure>> getBreeds() async {
    final response = await client.get('/breeds');

    return response.when(
      ok: (data) {
        final List<Breed> breeds = data.map<Breed>((item) => Breed.fromMap(item)).toList();
        return Result.ok(breeds);
      },
      err: (failure) {
        return Result.err(failure);
      },
    );
  }

  Future<Result<String, Failure>> getImageUrl(String referenceImageId) async {
    final response = await client.get('/images/$referenceImageId');
    return response.when(
      ok: (data) {
        final imageUrl = data['url'] as String?;
        if (imageUrl != null) {
          return Result.ok(imageUrl);
        } else {
          return const Result.err(Failure('Imagen no encontrada'));
        }
      },
      err: (failure) {
        return Result.err(failure);
      },
    );
  }
}

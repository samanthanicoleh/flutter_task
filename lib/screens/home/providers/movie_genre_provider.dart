// Provider with all genres mapped to ids
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/genre/genre.dart';

final genreListProvider = StateProvider<List<Genre>>((ref) => []);

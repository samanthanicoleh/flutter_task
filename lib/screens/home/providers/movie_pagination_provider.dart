import 'package:flutter_riverpod/flutter_riverpod.dart';

// Current page that user is on
final currentPageProvider = StateProvider<int>((ref) => 1);

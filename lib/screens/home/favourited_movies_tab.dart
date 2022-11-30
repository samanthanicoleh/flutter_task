import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../services/hive_service.dart';
import 'providers/movie_genre_provider.dart';
import 'providers/movie_provider.dart';
import 'widgets/movie_list_tile.dart';

class FavouritedMoviesTab extends ConsumerWidget {
  const FavouritedMoviesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listGenres = ref.watch(genreListProvider);

    return ref.watch(hiveStateProvider).when(
          data: (data) {
            final listFavouriteMovies = ref.watch(favouriteMovieListProvider);
            return Scaffold(
              backgroundColor: AppColors.secondaryDarkBlue,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppAssets.kQLogo,
                        height: 32.h,
                        width: 21.w,
                      ),
                      SizedBox(height: 12.h),
                      const Text(
                        'Favourites',
                        style: AppTextStyles.title,
                      ),
                      SizedBox(height: 20.h),
                      // List of movies
                      Expanded(
                        child: ListView.builder(
                          itemCount: listFavouriteMovies.length,
                          itemBuilder: (context, index) => MovieListTile(
                            movie: listFavouriteMovies[index],
                            listGenres: listGenres,
                            isFavouriteTab: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          loading: () => const CircularProgressIndicator(),
        );
  }
}

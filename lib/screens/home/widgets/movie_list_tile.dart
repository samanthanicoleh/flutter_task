import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/api.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../models/genre/genre.dart';
import '../../../models/movie/movie.dart';
import '../../../route/route_names.dart';
import '../../../services/hive_service.dart';
import '../../../widgets/favourite_movie_animated_icon.dart';
import '../../../widgets/genre_container.dart';
import '../providers/movie_provider.dart';

class MovieListTile extends ConsumerWidget {
  final Movie movie;
  final List<Genre> listGenres;
  final bool isFavouriteTab;
  const MovieListTile({required this.movie, required this.listGenres, this.isFavouriteTab = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
        onTap: () => context.pushNamed(
          RouteNames.details,
          params: {'id': movie.id.toString()},
          extra: listGenres,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie poster image
                CachedNetworkImage(
                  imageUrl: '${AppEndpoints.imageBaseUrl}${movie.posterPath}',
                  fit: BoxFit.fill,
                  width: 100.w,
                  height: 150.h,
                ),
                SizedBox(width: 12.w),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.originalTitle,
                        style: AppTextStyles.subtitle,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.kStarIcon,
                            width: 13.r,
                            height: 13.r,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '${movie.voteAverage.toStringAsFixed(1)} / 10 IMDb',
                            style: AppTextStyles.regular,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      if (movie.genreIds != null)
                        Wrap(
                          spacing: 2,
                          runSpacing: 4,
                          children: [
                            for (var genreId in movie.genreIds!) ...[
                              GenreContainer(
                                genre: listGenres.firstWhere((element) => element.id == genreId).name,
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Favourite icon
            trailing: isFavouriteTab
                ? const Icon(
                    Icons.bookmark_added,
                    key: ValueKey(BookmarkIcon.added),
                    color: AppColors.primaryColor,
                  )
                : FavouriteMovieAnimatedIcon(
                    addToFavourite: () {
                      ref.read(hiveStateProvider.notifier).addFavouriteMoviesToBox(movie: movie);
                      ref.read(favouriteMovieListProvider.notifier).update((state) => [movie, ...state]);
                    },
                    removeFromFavourite: () {
                      ref.read(hiveStateProvider.notifier).removeFavouriteMoviesToBox(movie: movie);
                      ref
                          .read(favouriteMovieListProvider.notifier)
                          .update((state) => state.where((element) => element.id != movie.id).toList());
                    },
                    isFavourite: ref.read(hiveStateProvider.notifier).checkIfBoxContains(movie: movie),
                  ),
          ),
        ),
      );
}

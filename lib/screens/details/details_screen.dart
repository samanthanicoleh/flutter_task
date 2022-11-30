import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../constants/api.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../models/genre/genre.dart';
import '../../models/movie/movie.dart';
import '../../services/hive_service.dart';
import '../../widgets/favourite_movie_animated_icon.dart';
import '../../widgets/genre_container.dart';
import '../home/providers/movie_provider.dart';
import 'details_provider.dart';

class DetailsScreen extends ConsumerWidget {
  final String? id;
  final List<Genre>? listGenres;
  const DetailsScreen({required this.id, this.listGenres, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsStateProvider(id ?? '0'));
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            movieDetails.when(
              data: (movieDetails) => Stack(
                children: [
                  // Header image with movie poster image
                  DetailsHeaderImage(
                    imageUrl: movieDetails.posterPath,
                  ),
                  // Movie details section
                  Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: DetailsSection(
                      movie: movieDetails,
                      listGenres: listGenres,
                      addToFavourite: () {
                        ref.read(hiveStateProvider.notifier).addFavouriteMoviesToBox(movie: movieDetails);
                        ref.read(favouriteMovieListProvider.notifier).update((state) => [movieDetails, ...state]);
                      },
                      removeFromFavourite: () {
                        ref.read(hiveStateProvider.notifier).removeFavouriteMoviesToBox(movie: movieDetails);
                        ref
                            .read(favouriteMovieListProvider.notifier)
                            .update((state) => state.where((element) => element.id != movieDetails.id).toList());
                      },
                      ref: ref,
                    ),
                  ),
                ],
              ),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsHeaderImage extends StatelessWidget {
  final String imageUrl;
  const DetailsHeaderImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topLeft,
        height: 350.h,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider('${AppEndpoints.imageBaseUrl}$imageUrl'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: context.pop,
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: SvgPicture.asset(
              AppAssets.kBackArrowIcon,
              width: 24.w,
              height: 12.h,
            ),
          ),
        ),
      );
}

class DetailsSection extends StatelessWidget {
  final Movie movie;
  final List<Genre>? listGenres;
  final Function() addToFavourite;
  final Function() removeFromFavourite;
  final WidgetRef ref;
  const DetailsSection(
      {required this.movie,
      required this.listGenres,
      required this.addToFavourite,
      required this.removeFromFavourite,
      required this.ref,
      super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.secondaryDarkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      movie.originalTitle,
                      style: AppTextStyles.title,
                    ),
                  ),
                  FavouriteMovieAnimatedIcon(
                    addToFavourite: addToFavourite,
                    removeFromFavourite: removeFromFavourite,
                    isFavourite: ref.read(hiveStateProvider.notifier).checkIfBoxContains(movie: movie),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
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
              SizedBox(height: 12.h),
              if (listGenres != null)
                Wrap(
                  spacing: 2,
                  runSpacing: 4,
                  children: [
                    for (var genre in movie.genres!) ...[
                      GenreContainer(
                        genre: listGenres!.firstWhere((element) => element.id == genre.id).name,
                      ),
                    ],
                  ],
                ),
              SizedBox(height: 12.h),
              const Text(
                'Description',
                style: AppTextStyles.subtitle,
              ),
              SizedBox(height: 12.h),
              Text(
                movie.overview,
                style: AppTextStyles.regular,
              ),
            ],
          ),
        ),
      );
}

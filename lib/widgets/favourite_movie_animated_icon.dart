import 'dart:developer';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

enum BookmarkIcon {
  outlined,
  added,
}

class FavouriteMovieAnimatedIcon extends StatefulWidget {
  final bool isFavourite;
  final Function() onPressed;

  const FavouriteMovieAnimatedIcon({
    required this.onPressed,
    this.isFavourite = false,
    super.key,
  });

  @override
  State<FavouriteMovieAnimatedIcon> createState() => _FavouriteMovieAnimatedIconState();
}

class _FavouriteMovieAnimatedIconState extends State<FavouriteMovieAnimatedIcon> {
  late bool isFavourite = widget.isFavourite;

  @override
  Widget build(BuildContext context) => IconButton(
        splashColor: Colors.red,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => RotationTransition(
            turns: child.key == const ValueKey(BookmarkIcon.outlined)
                ? Tween<double>(begin: 1, end: 1).animate(animation)
                : Tween<double>(begin: 1, end: 1).animate(animation),
            child: ScaleTransition(scale: animation, child: child),
          ),
          child: !isFavourite
              ? const Icon(
                  Icons.bookmark_outline,
                  key: ValueKey(BookmarkIcon.outlined),
                  color: AppColors.textColor,
                )
              : const Icon(
                  Icons.bookmark_added,
                  key: ValueKey(BookmarkIcon.added),
                  color: AppColors.primaryColor,
                ),
        ),
        onPressed: () => setState(() {
          isFavourite = !isFavourite;
          widget.onPressed();
        }),
      );
}

import 'package:flutter/material.dart';

import '../constants/colors.dart';

enum BookmarkIcon {
  outlined,
  added,
}

class FavouriteMovieAnimatedIcon extends StatefulWidget {
  final Function() addToFavourite;
  final Function() removeFromFavourite;
  final bool isFavourite;
  const FavouriteMovieAnimatedIcon(
      {required this.addToFavourite, required this.removeFromFavourite, this.isFavourite = false, super.key});

  @override
  State<FavouriteMovieAnimatedIcon> createState() => _FavouriteMovieAnimatedIconState();
}

class _FavouriteMovieAnimatedIconState extends State<FavouriteMovieAnimatedIcon> {
  int _currentIcon = 0;
  bool isFavourite = false;

  @override
  void initState() {
    // Current icon 0 - bookmark outlined, 1 - bookmark added
    _currentIcon = widget.isFavourite ? BookmarkIcon.added.index : BookmarkIcon.outlined.index;
    isFavourite = widget.isFavourite;
    super.initState();
  }

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
          child: _currentIcon == 0
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
        onPressed: () {
          setState(() {
            _currentIcon = _currentIcon == 0 ? 1 : 0;
          });
          widget.isFavourite ? widget.removeFromFavourite() : widget.addToFavourite();
          isFavourite = !isFavourite;
        },
      );
}

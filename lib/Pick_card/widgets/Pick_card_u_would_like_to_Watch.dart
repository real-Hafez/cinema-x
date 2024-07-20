import 'dart:ui';
import 'package:cinema_x/Pick_card/models/fav_genre_model.dart';
import 'package:flutter/material.dart';

class Pick_card_u_would_like_to_Watch extends StatefulWidget {
  const Pick_card_u_would_like_to_Watch(
      {super.key,
      required this.favGenre,
      required this.isSelected,
      required this.onSelected});
  final FavGenre favGenre;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  State<Pick_card_u_would_like_to_Watch> createState() =>
      _Pick_card_u_would_like_to_WatchState();
}

class _Pick_card_u_would_like_to_WatchState
    extends State<Pick_card_u_would_like_to_Watch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onSelected(!widget.isSelected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: widget.isSelected
              ? Border.all(color: Colors.blue, width: 4)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(
                widget.favGenre.photo,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.favGenre.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (widget.isSelected)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 36,
                    applyTextScaling: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

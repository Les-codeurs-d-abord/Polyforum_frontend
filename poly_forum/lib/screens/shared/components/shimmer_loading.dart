import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final int nbBlock;
  final int nbLine;

  const ShimmerLoading({required this.nbBlock, required this.nbLine, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < nbLine; i++)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            ],
          ),
        ),
        itemCount: nbBlock,
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}

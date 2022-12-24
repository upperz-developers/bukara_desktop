import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' as mat;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:bukara/app/providers/shared/common_models.dart' as img;

class SuiteGaleryImage extends StatefulWidget {
  final List<img.Image>? images;
  final int? index;
  const SuiteGaleryImage({Key? key, this.images, this.index}) : super(key: key);

  @override
  State<SuiteGaleryImage> createState() => _SuiteGaleryImageState();
}

class _SuiteGaleryImageState extends State<SuiteGaleryImage>
    with mat.SingleTickerProviderStateMixin {
  mat.PageController? _controller;
  int i = 0;
  bool hasStated = true;
  @override
  void initState() {
    _controller = mat.PageController(
      initialPage: widget.index!,
    );
    i = widget.index!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Acrylic(
      blurAmount: 10,
      luminosityAlpha: .1,
      tint: Colors.black,
      child: mat.Stack(
        children: [
          mat.PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) => mat.SizedBox(
              width: mat.MediaQuery.of(context).size.width,
              child: ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image:
                        CachedNetworkImageProvider(widget.images![index].url!),
                  )),
                ),
              ),
            ),
            itemCount: widget.images!.length,
          ),
          mat.Positioned(
            top: 30,
            right: 30,
            child: mat.Container(
              decoration: mat.BoxDecoration(
                color: Colors.black.withOpacity(.3),
                borderRadius: mat.BorderRadius.circular(4),
              ),
              child: mat.InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const mat.Padding(
                  padding: mat.EdgeInsets.all(15),
                  child: Icon(
                    mat.Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          mat.Positioned(
            top: 0,
            bottom: 0,
            left: 30,
            right: 30,
            child: mat.Row(
              mainAxisAlignment: mat.MainAxisAlignment.spaceBetween,
              children: [
                i > 0
                    ? mat.Container(
                        decoration: mat.BoxDecoration(
                          borderRadius: mat.BorderRadius.circular(4),
                          color: Colors.black.withOpacity(.3),
                        ),
                        child: mat.InkWell(
                          onTap: () {
                            setState(() {
                              i--;
                              _controller!.animateToPage(
                                i,
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                                curve: mat.Curves.easeInOutSine,
                              );
                            });
                          },
                          child: const mat.Padding(
                            padding: mat.EdgeInsets.all(25),
                            child: Icon(
                              mat.Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                i < 4
                    ? mat.Container(
                        decoration: mat.BoxDecoration(
                          borderRadius: mat.BorderRadius.circular(4),
                          color: Colors.black.withOpacity(.3),
                        ),
                        child: mat.InkWell(
                          onTap: () {
                            setState(() {
                              i++;
                              _controller!.animateToPage(
                                i,
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                                curve: mat.Curves.easeInOutSine,
                              );
                            });
                          },
                          child: const mat.Padding(
                            padding: mat.EdgeInsets.all(25),
                            child: Icon(
                              mat.Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    : mat.Container(),
              ],
            ),
          ),
          mat.Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: mat.Container(
              alignment: Alignment.center,
              padding:
                  const mat.EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: mat.BoxDecoration(
                borderRadius: mat.BorderRadius.circular(30),
              ),
              child: mat.Wrap(
                spacing: 10,
                crossAxisAlignment: mat.WrapCrossAlignment.center,
                children: List.generate(
                  widget.images!.length,
                  (index) => mat.InkWell(
                    onTap: () {
                      setState(() {
                        i = index;
                        _controller!.animateToPage(
                          i,
                          duration: const Duration(
                            milliseconds: 1000,
                          ),
                          curve: mat.Curves.easeInOutSine,
                        );
                      });
                    },
                    child: mat.AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 1000,
                      ),
                      height: index == i ? 30 : 20,
                      width: index == i ? 30 : 20,
                      decoration: mat.BoxDecoration(
                          boxShadow: [
                            mat.BoxShadow(
                              offset: const mat.Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.grey.withOpacity(.3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(4),
                          color: index == i
                              ? FluentTheme.of(context).activeColor
                              : FluentTheme.of(context).disabledColor,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              widget.images![index].url!,
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

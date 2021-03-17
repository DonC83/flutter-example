import 'package:bubble/bubble.dart';
import 'package:bubble_showcase/bubble_showcase.dart';
import 'package:flutter/material.dart';


class IntroShowcase extends StatelessWidget {
  final GlobalKey _libraryKey;
  final GlobalKey _captureKey;
  final GlobalKey _mapKey;
  final Widget _mainWidget;
  final int buildNum;

  const IntroShowcase(this.buildNum, this._libraryKey, this._captureKey,
      this._mapKey, this._mainWidget);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
      color: Colors.white,
    );
    return BubbleShowcase(
      bubbleShowcaseId: 'main_showcase',
      bubbleShowcaseVersion: buildNum,
      doNotReopenOnClose: true,
      bubbleSlides: [
        zeroSlide(textStyle, size.width, _libraryKey),
        secondSlide(textStyle, size.width, _captureKey),
        thirdSlide(textStyle, size.width, _mapKey)
      ],
      child: _mainWidget,
    );
  }
}

BubbleSlide zeroSlide(
        TextStyle textStyle, double screenWidth, GlobalKey libraryKey) =>
    RelativeBubbleSlide(
      shape: Oval(spreadRadius: 20),
      widgetKey: libraryKey,
      child: AbsoluteBubbleSlideChild(
          positionCalculator: (size) => Position(
                top: size.height - 115,
                left: 0,
              ),
          widget: Bubble(
              nip: BubbleNip.no,
              color: Colors.transparent,
              child: Container(
                  width: screenWidth - 30,
                  child: Text(
                      'Use the Library to find items that can\'t be identified or to browse',
                      textAlign: TextAlign.center,
                      style: textStyle)))),
    );

BubbleSlide firstSlide(
        TextStyle textStyle, double screenWidth, GlobalKey galleryKey) =>
    RelativeBubbleSlide(
      shape: Oval(spreadRadius: 20),
      widgetKey: galleryKey,
      child: AbsoluteBubbleSlideChild(
          positionCalculator: (size) => Position(
                top: size.height - 115,
                left: 0,
              ),
          widget: Bubble(
              nip: BubbleNip.no,
              color: Colors.transparent,
              child: Container(
                  width: screenWidth - 30,
                  child: Text(
                      'Tap on Gallery to choose an image from your phone to try identify.',
                      textAlign: TextAlign.center,
                      style: textStyle)))),
    );

BubbleSlide secondSlide(
        TextStyle textStyle, double screenWidth, GlobalKey captureKey) =>
    RelativeBubbleSlide(
      shape: Oval(spreadRadius: 20),
      widgetKey: captureKey,
      child: AbsoluteBubbleSlideChild(
          positionCalculator: (size) => Position(
                top: size.height - 115,
                left: 0,
              ),
          widget: Bubble(
              nip: BubbleNip.no,
              color: Colors.transparent,
              child: Container(
                  width: screenWidth - 30,
                  child: Text(
                      'Use Capture to take a photo of something to try identify',
                      textAlign: TextAlign.center,
                      style: textStyle)))),
    );

BubbleSlide thirdSlide(
        TextStyle textStyle, double screenWidth, GlobalKey mapKey) =>
    RelativeBubbleSlide(
      shape: Oval(spreadRadius: 20),
      widgetKey: mapKey,
      child: AbsoluteBubbleSlideChild(
          positionCalculator: (size) => Position(
                top: size.height - 115,
                left: 0,
              ),
          widget: Bubble(
              nip: BubbleNip.no,
              color: Colors.transparent,
              child: Container(
                  width: screenWidth - 30,
                  child: Text(
                      'Maps can be used to find a transfer station near you.',
                      textAlign: TextAlign.center,
                      style: textStyle)))),
    );

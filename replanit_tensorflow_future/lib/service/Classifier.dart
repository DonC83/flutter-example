import 'package:tflite/tflite.dart';

class Classifier {
  String tfLiteModel;

  Classifier() {
    loadModel();
  }

  Future loadModel() async {
    if (Tflite != null) {
      Tflite.close();
    }
    try {
      tfLiteModel = await Tflite.loadModel(
          model: 'assets/recycle_model.tflite',
          labels: 'assets/recycle_labels.txt',
          numThreads: 1);
    } catch (e) {
      print('Failed to load the classification model $e');
    }
  }

  Future<List<dynamic>> recognizeImage(String imagePath) async {
    if (imagePath == null) {
      return null;
    }
    var recognitions =  await Tflite.runModelOnImage(
        path: imagePath,
        numResults: 3,
        threshold: 0.75,
        imageMean: 0.0,
        imageStd: 255,
        asynch: true);

    return recognitions;
  }

}

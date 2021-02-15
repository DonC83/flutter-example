
import 'package:replanit_tensorflow_future/model/category.dart';
import 'package:replanit_tensorflow_future/model/disposable.dart';
import 'package:replanit_tensorflow_future/model/disposing.dart';
import 'package:replanit_tensorflow_future/model/item.dart';
import 'package:replanit_tensorflow_future/model/program.dart';

class DisposableItem {
  final Item item;
  final List<Program> programs;
  final Category category;
  final Disposable disposable;
  final Disposing disposing;

  DisposableItem(
      {this.item,
      this.programs,
      this.category,
      this.disposable,
      this.disposing});
}

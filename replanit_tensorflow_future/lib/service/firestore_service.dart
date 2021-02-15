import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:replanit_tensorflow_future/model/category.dart';
import 'package:replanit_tensorflow_future/model/disposable.dart';
import 'package:replanit_tensorflow_future/model/disposable_item.dart';
import 'package:replanit_tensorflow_future/model/disposing.dart';
import 'package:replanit_tensorflow_future/model/item.dart';
import 'package:replanit_tensorflow_future/model/program.dart';

class FirestoreService {

  static FirebaseFirestore _firestore;

  static final FirestoreService instance = FirestoreService();

  static const COL_CATEGORY = 'category';
  static const COL_DISPOSING = 'disposing';
  static const COL_ITEM = 'item';
  static const COL_LOCATIONS = 'locations';
  static const COL_PROGRAM = 'program';

  Future<FirebaseFirestore> get firestore async {
    if (_firestore != null) return _firestore;
    _firestore = FirebaseFirestore.instance;
    return _firestore;
  }

  Future<List<DisposableItem>> findItemsByCategory(String category) async {
    FirebaseFirestore firestore = await FirestoreService.instance.firestore;
    QuerySnapshot results = await firestore
        .collection(COL_ITEM)
        .where('category', isEqualTo: category)
        .get();

    List<DisposableItem> disposableItems = List();
    results.docs.forEach((element) async {
      Item item = Item().fromMapWithId(element.id, element.data());
      Category category = Category(name: element.data()['category']);
      Disposing disposing =
      Disposing().fromMapWithoutId(element.data()['disposing']);
      Disposable disposable = Disposable(item: item, disposing: disposing);
      findProgramByIds(item.programs)
          .then((value) => disposable.item.programs = value);

      // List<Program> programs = await findProgramByIds(item.programs);
      // item.programs = programs;

      disposableItems.add(DisposableItem(
        item: item,
        category: category,
        disposing: disposing,
        disposable: disposable,
        // programs: programs
      ));
    });

    return disposableItems;
  }

  Future<List<Program>> findProgramByIds(List<dynamic> programIds) async {
    List<Program> programs = List();
    if (programIds == null) {
      return programs;
    }
    FirebaseFirestore firestore = await FirestoreService.instance.firestore;
    CollectionReference programCol = firestore.collection(COL_PROGRAM);
    for (String i in programIds) {
      DocumentSnapshot doc = await programCol.doc(i).get();
      programs.add(Program().fromMap(doc.data()));
    }
    return programs;
  }


}
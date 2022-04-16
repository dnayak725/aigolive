class Category {
  final String id;
  final String name;
  final String iType;
  final String catId;
  final String parentID;
  final String image;
  final List<SubCategory> subCatList;
  Category({
    this.id,
    this.name,
    this.iType,
    this.catId,
    this.parentID,
    this.image,
    this.subCatList,
  });
}

class SubCategory {
  final String id;
  final String name;
  final String image;
  SubCategory({
    this.id,
    this.name,
    this.image,
  });
}

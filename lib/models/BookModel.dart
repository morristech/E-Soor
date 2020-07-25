class Book {
  final String id;
  final String info;
  final String authorID;
  final String authorName;
  final String displayName;
  final String price;
  final String picUrl;
  final DateTime creationTime;
  final DateTime lastInfoUpdate;
  final String category;
  final String categoryID;
  final int quantity;
  Book({
    this.quantity,
    this.info,
    this.category,
    this.categoryID,
    this.authorName,
    this.creationTime,
    this.lastInfoUpdate,
    this.id,
    this.authorID,
    this.displayName,
    this.price,
    this.picUrl,
  });

  // formatting for upload to Firbase when creating the new Book
  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'info': info,
      'id': id,
      'displayName': displayName,
      'authorID': authorID,
      'authorName': authorName,
      'price': price,
      'picUrl': picUrl,
      'category': category,
      'categoryID': categoryID,
      'creationTime': creationTime,
      'lastInfoUpdate': lastInfoUpdate,
    };
  }

  // creating a Book object from request data
  Book.fromJson(dynamic data)
      : id = data['id'],
        quantity = data['quantity'],
        info = data['info'],
        displayName = data['displayName'],
        authorID = data['authorID'],
        authorName = data['authorName'],
        price = data['price'],
        picUrl = data['picUrl'],
        category = data['category'],
        categoryID = data['categoryID'],
        creationTime = data['creationTime'],
        lastInfoUpdate = data['lastInfoUpdate'];
}

/*

1- Pic
2- Author
3- Average Rating
4- Name
5- Price
6- Category
7- Feedbacks
8- Your feedback (if isn’t null)
9- SubCategory (if isn’t null)


 */

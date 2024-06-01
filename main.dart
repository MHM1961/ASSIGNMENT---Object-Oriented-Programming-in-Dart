import 'dart:io';
import 'dart:convert';

// Define an interface
abstract class Describable {
  void describe();
}

// Define a base class for Item
class Item implements Describable {
  String name;

  Item(this.name);

  @override
  void describe() {
    print('Item: $name');
  }
}

// Define a subclass for Book that inherits from Item
class Book extends Item {
  String author;

  Book(String name, this.author) : super(name);

  @override
  void describe() {
    print('Book: $name by $author');
  }
}

// Define a class for User
class User {
  String name;
  List<Book> borrowedBooks = [];

  User(this.name);

  void borrowBook(Book book) {
    borrowedBooks.add(book);
    print('$name borrowed "${book.name}"');
  }

  void listBorrowedBooks() {
    print('$name has borrowed:');
    for (var book in borrowedBooks) {
      print('- ${book.name} by ${book.author}');
    }
  }
}

// A function to read data from a file and initialize a User instance
Future<User> initializeUserFromFile(String filePath) async {
  var file = File(filePath);
  var contents = await file.readAsString();
  var data = jsonDecode(contents);

  var user = User(data['name']);
  for (var bookData in data['borrowedBooks']) {
    var book = Book(bookData['name'], bookData['author']);
    user.borrowBook(book);
  }

  return user;
}

void main() async {
  // Example file path
  var filePath = 'user_data.json';

  // Initialize user from file
  var user = await initializeUserFromFile(filePath);

  // Demonstrate the use of a loop
  user.listBorrowedBooks();
}

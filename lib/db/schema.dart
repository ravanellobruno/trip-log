class Schema {
  static const createPlacesTable = '''
    CREATE TABLE places (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      base64Img TEXT, 
      name TEXT NOT NULL, 
      description TEXT, 
      type TEXT NOT NULL 
    );
  ''';
}

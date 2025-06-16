

class Bank {
  final String id;
  final String name;

  Bank({required this.id, required this.name});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['banks_name'],
    );
  }
}

class Wallet {
  final String id;
  final String walletName;

  Wallet({required this.id, required this.walletName});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      walletName: json['banks_name'],
    );
  }
}

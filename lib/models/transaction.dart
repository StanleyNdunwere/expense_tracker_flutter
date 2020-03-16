class Transaction{
	String _id;
	String _title;
	double _amount;
	DateTime _date;


	Transaction({String id, String title, double amount, DateTime date}){
		this._id = id;
		this._title = title;
		this._amount = amount;
		this._date = date;
	}

	String get id => _id;

	String get title => _title;

	DateTime get date => _date;

	double get amount => _amount;

}
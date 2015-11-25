# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Book.destroy_all
Reviewer.destroy_all

Book.create! ([
	{ name: "aEloqiemt rinu", author: "Russ Olsen"},
	{ name: "aEloqiemt rinu1", author: "Russ Olsesan"},
	{ name: "aEloqiemt rinu2", author: "Russ Olsen1"},
	{ name: "aEloqiemt rinu3", author: "Russ Olsen23"}
])

100.times { |index| Book.create! name: "Book#{index}", author: "Author#{index}" }

book1 = Book.find_by name: "aEloqiemt rinu"

book1.notes.create! [
	{ title: "Wow", note: "Greate book"},
	{ title: "Wow", note: "Greate book3"},
	{ title: "Wow", note: "Greate book ruby"}
]

reviewers = Reviewer.create! [
	{name: "Joe", password: "abc123"},
	{name: "Jim", password: "abc1323"},
]

Book.all.each do |book|
	book.reviewer = reviewers.sample
	book.save
end
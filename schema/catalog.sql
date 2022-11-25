Create Table genre(
	id INT Generated always as identity PRIMARY KEY,
	name varchar(50) NOT NULL
)

Create table music_album(
	id INT NOT NULL PRIMARY KEY,
	on_spotify BOOLEAN NOT NULL,
	genre_id INT References genre(id),
	author_id INT References author(id),
	source_id INT References source(id),
	label_id INT References label(id),
	publish_date DATE,
	archived BOOLEAN
)

Create table movies(
	id INT NOT NULL PRIMARY KEY,
	on_spotify BOOLEAN NOT NULL,
	silent BOOLEAN NOT NULL,
	can_be_archive BOOLEAN NOT NULL,
	genre_id INT References genre(id),
	author_id INT References author(id),
	source_id INT References source(id),
	label_id INT References label(id),
	publish_date DATE,
	archived BOOLEAN
)

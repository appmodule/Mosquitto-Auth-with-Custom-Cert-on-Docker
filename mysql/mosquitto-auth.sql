DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id INTEGER AUTO_INCREMENT,
	username VARCHAR(25) NOT NULL,
	pw VARCHAR(128) NOT NULL,
	super INT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
  );

CREATE UNIQUE INDEX users_username ON users (username);

DROP TABLE IF EXISTS acls;

CREATE TABLE acls (
	id INTEGER AUTO_INCREMENT,
	username VARCHAR(25) NOT NULL,
	topic VARCHAR(256) NOT NULL,
	rw INTEGER(1) NOT NULL DEFAULT 1,	-- 1: read-only, 2: read-write
	PRIMARY KEY (id)
	);
CREATE UNIQUE INDEX acls_user_topic ON acls (username, topic(228));

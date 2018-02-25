DROP TABLE IF EXISTS users;

CREATE SEQUENCE users_seq;

CREATE TABLE users (
        id INTEGER DEFAULT NEXTVAL ('users_seq'),
        username VARCHAR(25) NOT NULL,
        pw VARCHAR(128) NOT NULL,
        super INT NOT NULL DEFAULT 0,
        PRIMARY KEY (id)
  );

CREATE UNIQUE INDEX users_username ON users (username);

DROP TABLE IF EXISTS acls;

CREATE SEQUENCE acls_seq;

CREATE TABLE acls (
        id INTEGER DEFAULT NEXTVAL ('acls_seq'),
        username VARCHAR(25) NOT NULL,
        topic VARCHAR(256) NOT NULL,
        rw INTEGER NOT NULL DEFAULT 1,       -- 1: read-only, 2: write, 3: read-write
        PRIMARY KEY (id)
        );
CREATE UNIQUE INDEX acls_user_topic ON acls (username, topic);

INSERT INTO users (username, pw) VALUES ('test', 'PBKDF2$sha256$901$jNsTQeM810RWf9z9$+5qxPKIMxfy/nuhUUtgUm+tyO/ewCzuy'); -- pass is test123
INSERT INTO users (username, pw, super) VALUES ('super', 'PBKDF2$sha256$901$AEz7dV6JGOuqmUe4$n/Jb9oN1WDdzO6TLxHC8eMx4wdPDODkZ', 1); -- pass is super123

INSERT INTO acls (username, topic, rw) VALUES ('test', 'test/#', 3);
INSERT INTO acls (username, topic, rw) VALUES ('super', '#', 3);

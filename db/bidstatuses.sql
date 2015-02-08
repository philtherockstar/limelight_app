PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "bidstatuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, status varchar(64));
INSERT INTO "bidstatuses" VALUES(1,'New');
INSERT INTO "bidstatuses" VALUES(2,'Proposal Sent');
INSERT INTO "bidstatuses" VALUES(3,'Contract Sent');
INSERT INTO "bidstatuses" VALUES(4,'Contract Signed');
COMMIT;


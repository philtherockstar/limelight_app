PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "room_prices" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "price" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "business_id" integer, "room_id" integer);
INSERT INTO "room_prices" VALUES(1,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,3);
INSERT INTO "room_prices" VALUES(2,200,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,1);
INSERT INTO "room_prices" VALUES(3,150,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,17);
INSERT INTO "room_prices" VALUES(4,75,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,20);
INSERT INTO "room_prices" VALUES(5,150,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,19);
INSERT INTO "room_prices" VALUES(6,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,14);
INSERT INTO "room_prices" VALUES(7,500,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,7);
INSERT INTO "room_prices" VALUES(8,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,5);
INSERT INTO "room_prices" VALUES(9,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,15);
INSERT INTO "room_prices" VALUES(10,150,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,8);
INSERT INTO "room_prices" VALUES(11,75,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,9);
INSERT INTO "room_prices" VALUES(12,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,18);
INSERT INTO "room_prices" VALUES(13,500,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,6);
INSERT INTO "room_prices" VALUES(14,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,12);
INSERT INTO "room_prices" VALUES(15,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,4);
INSERT INTO "room_prices" VALUES(16,250,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,2);
INSERT INTO "room_prices" VALUES(17,300,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,16);
INSERT INTO "room_prices" VALUES(18,150,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,10);
INSERT INTO "room_prices" VALUES(19,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,11);
INSERT INTO "room_prices" VALUES(20,50,'2015-01-17 22:28:35','2015-01-17 22:28:35',1,13);
CREATE INDEX "index_room_prices_on_business_id" ON "room_prices" ("business_id");
CREATE INDEX "index_room_prices_on_room_id" ON "room_prices" ("room_id");
CREATE INDEX "idx_room_prices_on_busi_room_ids" ON "room_prices" ("business_id","room_id");
COMMIT;

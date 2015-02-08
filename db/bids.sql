PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "bids" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "property_id" integer(11) NOT NULL, "bidstatus_id" integer(11), "bid_date" datetime, "bid_total" decimal(5,2), "staging_fee" decimal(5,2), "distribution_fee" decimal(5,2), "rental_weekly" decimal(5,2), "rental_monthly" decimal(5,2), "rental" decimal(5,2), "weeks_included" integer(4), "complimentary_weeks" integer(4), "discount_percent" integer(4) DEFAULT 0, "discount_amount" decimal(5,2) DEFAULT 0.0 );
INSERT INTO "bids" VALUES(67,5,1,NULL,0,1325,250,215.75,863,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(68,6,1,'2015-02-05 18:45:51.530989',0,1375,250,227,908,1362,6,NULL,0,0);
INSERT INTO "bids" VALUES(69,7,1,NULL,0,1200,300,172.75,691,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(70,8,1,NULL,0,1125,250,172.75,691,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(71,9,1,NULL,0,1500,250,250,1000,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(72,10,1,NULL,0,1175,250,NULL,NULL,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(73,11,1,NULL,0,1150,250,182.75,731,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(74,12,1,'2015-02-03 02:00:51.464667',0,1800,250,324.5,1298,1947,6,NULL,0,0);
INSERT INTO "bids" VALUES(75,5,1,NULL,0,1175,250,181.5,726,NULL,6,NULL,0,0);
INSERT INTO "bids" VALUES(76,12,1,'2015-02-01 01:47:47.774489',0,1525,250,259.5,1038,1557,6,NULL,0,0);
INSERT INTO "bids" VALUES(77,13,1,'2015-02-04 23:00:22.498765',0,1095,250,175,700,1050,6,NULL,0,0);
CREATE INDEX "bids_bids_uidx1" ON "bids" ("property_id", "bid_date");
CREATE INDEX "bids_bids_idx1" ON "bids" ("property_id");
COMMIT;


PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "properties" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "address" varchar(128) , "city" varchar(128) , "state_id" integer(11), "province_id" integer(11), "country_id" integer(11) NOT NULL, "sqft" integer(11), "listing_price" integer(11), "selling_price" integer(11), "est_closing_date" date, "status" text, "business_id" integer(11) NOT NULL);
CREATE INDEX "properties_properties_idx1" ON "properties" ("business_id", "address");
CREATE INDEX "properties_properties_fk1_idx" ON "properties" ("business_id");
CREATE INDEX "properties_properties_fk3_idx" ON "properties" ("country_id");
CREATE INDEX "properties_properties_fk2_idx" ON "properties" ("state_id");
CREATE UNIQUE INDEX "properties_uidx" ON "properties" ("business_id","address","city","state_id","country_id");
COMMIT;

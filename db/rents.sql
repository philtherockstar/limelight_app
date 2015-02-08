PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "rents" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
  "property_id" integer(11) NOT NULL, 
  "stage_id" integer(11), 
  "transaction_date" datetime, 
  "rent_due" decimal(5,2) default 0, 
  "rent_paid" decimal(5,2) default 0, 
  "rent_days" integer(2) default 0, 
  "refund_amount" decimal(5,2) default 0 
  );
CREATE INDEX "rents_ni1" ON "rents" ("property_id");
CREATE INDEX "rents_ni2" ON "rents" ("stage_id");
COMMIT;

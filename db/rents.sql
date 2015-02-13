PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "rents" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
  "property_id" integer(11) NOT NULL, 
  "stage_id" integer(11), 
  "rent_due" decimal(5,2), 
  "rent_due_on" datetime,
  "rent_paid" decimal(5,2), 
  "rent_paid_on" datetime,
  "rent_payment_method" varchar(8),
  "rent_days" integer(2) default 0, 
  "refunded_amount" decimal(5,2) default 0,
  "refunded_on" datetime,
  "refunded_days" integer(2)
  );
CREATE INDEX "rents_ni1" ON "rents" ("property_id");
CREATE INDEX "rents_ni2" ON "rents" ("stage_id");
CREATE INDEX "rents_ni3" ON "rents" ("stage_id","rent_due_on");
CREATE INDEX "rents_ni4" ON "rents" ("stage_id","rent_due_on","rent_paid");
COMMIT;

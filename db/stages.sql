CREATE TABLE "stages" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "bid_id" integer(11) ,
  "property_id" integer(11) NOT NULL ,
  "realtor_id" integer(11) ,
  "total" decimal(5,2),
  "rent" decimal(5,2),
  "stage_date" datetime,
  "tentative_destage_date" datetime,
  "destage_date" datetime
  );
CREATE INDEX "stages_ui1" ON "stages" ("bid_id");
CREATE INDEX "stages_ni1" ON "stages" ("property_id");
CREATE INDEX "stages_ni2" ON "stages" ("stage_date");

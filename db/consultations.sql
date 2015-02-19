CREATE TABLE "consultations" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "property_id" integer(11) NOT NULL ,
  "client_id" integer(11) ,
  "realtor_id" integer(11) ,
  "fee" decimal(5,2),
  "minutes" integer(3),
  "consultation_date" datetime
  );
CREATE INDEX "consultations_ni1" ON "consultations" ("property_id");
CREATE INDEX "consultations_ni2" ON "consultations" ("consultation_date");

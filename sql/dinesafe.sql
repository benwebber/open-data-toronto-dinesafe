CREATE TEMPORARY TABLE tmp AS
SELECT
  "Establishment ID",
  "Establishment Name",
  "Establishment Type",
  "Establishment Address",
  "Latitude",
  "Longitude",
  "Min. Inspections Per Year",
  "Inspection ID",
  "Inspection Date",
  "Establishment Status",
  "Infraction Details",
  "Severity",
  "Action",
  "Outcome",
  "Amount Fined"
FROM
  data.dinesafe
UNION
SELECT
  "Establishment ID",
  "Establishment Name",
  "Establishment Type",
  "Establishment Address",
  "Latitude",
  "Longitude",
  "Min. Inspections Per Year",
  "Inspection ID",
  "Inspection Date",
  "Establishment Status",
  "Infraction Details",
  "Severity",
  "Action",
  "Outcome",
  "Amount Fined"
FROM
  data.dinesafe_archive
;


DROP TABLE IF EXISTS establishment;
CREATE TABLE establishment (
  uid TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT NOT NULL,
  address TEXT NOT NULL,
  lat REAL NOT NULL,
  lon REAL NOT NULL,
  geometry AS (
    json_object(
      'type', 'Point',
      'coordinates', json_array(lon, lat)
    )
  ),
  min_inspections_per_year INTEGER NOT NULL
);
INSERT INTO establishment
SELECT
  "Establishment ID",
  "Establishment Name",
  "Establishment Type",
  "Establishment Address",
  "Latitude",
  "Longitude",
  "Min. Inspections Per Year"
FROM
  tmp
GROUP BY
  "Establishment ID"
HAVING
  MAX("Inspection ID")
;
CREATE INDEX idx_establishment_type ON establishment (type);

DROP TABLE IF EXISTS establishment_fts;
CREATE VIRTUAL TABLE establishment_fts USING fts5 (name, address, content="establishment");
INSERT INTO establishment_fts (rowid, name, address) SELECT rowid, name, address FROM establishment;

DROP TABLE IF EXISTS inspection;
CREATE TABLE inspection (
  uid TEXT NOT NULL PRIMARY KEY,
  establishment_uid TEXT NOT NULL,
  date TEXT NOT NULL,
  status TEXT NOT NULL,
  FOREIGN KEY (establishment_uid) REFERENCES establishment (uid),
  UNIQUE (establishment_uid, uid)
);
INSERT OR IGNORE INTO inspection
SELECT
  "Inspection ID",
  "Establishment ID",
  "Inspection Date",
  "Establishment Status"
FROM
  tmp
WHERE
  "Inspection ID" != ''
;
CREATE INDEX idx_inspection_establishment_uid ON inspection (establishment_uid);
CREATE INDEX idx_inspection_date ON inspection (date);
CREATE INDEX idx_inspection_status ON inspection (status);

DROP TABLE IF EXISTS infraction;
CREATE TABLE infraction (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  establishment_uid TEXT NOT NULL,
  inspection_uid TEXT NOT NULL,
  details TEXT NOT NULL,
  severity TEXT NOT NULL,
  action TEXT NOT NULL,
  outcome TEXT NULL,
  amount_fined TEXT NULL,
  FOREIGN KEY (establishment_uid) REFERENCES establishment (uid),
  FOREIGN KEY (inspection_uid) REFERENCES inspection (uid)
);
INSERT INTO infraction
SELECT
  NULL,
  "Establishment ID",
  "Inspection ID",
  "Infraction Details",
  "Severity",
  "Action",
  nullif("Outcome", ''),
  nullif("Amount Fined", '')
FROM
  tmp
WHERE
  "Infraction Details" != ''
;
CREATE INDEX idx_infraction_establishment_uid ON infraction (establishment_uid);
CREATE INDEX idx_infraction_inspection_uid ON infraction (inspection_uid);
CREATE INDEX idx_infraction_severity ON infraction (severity);
CREATE INDEX idx_infraction_action ON infraction (action);
CREATE INDEX idx_infraction_outcome ON infraction (outcome);

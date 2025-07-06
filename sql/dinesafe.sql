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
  data.dinesafe
GROUP BY
  "Establishment ID"
HAVING
  MAX("Inspection ID")
;

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
  data.dinesafe
WHERE
  "Inspection ID" != ''
;

DROP TABLE IF EXISTS infraction;
CREATE TABLE infraction (
  uid TEXT NOT NULL PRIMARY KEY,
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
  "unique_id",
  "Establishment ID",
  "Inspection ID",
  "Infraction Details",
  "Severity",
  "Action",
  nullif("Outcome", ''),
  nullif("Amount Fined", '')
FROM
  data.dinesafe
WHERE
  "Infraction Details" != ''
;

DROP TABLE IF EXISTS dinesafe;
DROP TABLE IF EXISTS dinesafe_archive;
.import 'data/dinesafe.csv' dinesafe --csv
.import 'data/dinesafe.2001.csv' dinesafe_archive -v --csv
.import 'data/dinesafe.2002.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2003.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2004.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2005.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2006.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2007.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2008.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2009.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2010.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2011.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2012.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2013.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2014.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2015.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2016.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2017.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2018.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2019.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2020.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2021.csv' dinesafe_archive -v --csv --skip 1
.import 'data/dinesafe.2022.csv' dinesafe_archive -v --csv --skip 1

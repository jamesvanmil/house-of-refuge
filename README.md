#Cincinnati House of Refuge Project

Welcome to the Cincinnati House of Refuge Project. This is the repository for the developing site to feature a searchable database of over 6,000 records of children admitted to the House of Refuge from 1869-1902.

Explore the database, read about the history of refuge in Cincinnati, and look at photographs, maps, and documents. We hope that this site helps you learn more about the lives of children in the Queen City.

##Image Gallery Configuration

To import gallery images with metadata, place image metadata in CSV under /tmp/
  * Filename: "hor_images.csv"
  * Columns (in order): file_name, title, creator, date, description, source_text, source_link, format, subject.
  * *file_name* should be a local (in-app) url to the associated, full size image file. e.g. /tmp/hor_images/\*

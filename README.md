#Cincinnati House of Refuge Project

Welcome to the Cincinnati House of Refuge Project. This is the repository for the developing site to feature a searchable database of over 6,000 records of children admitted to the House of Refuge from 1869-1902.

Explore the database, read about the history of refuge in Cincinnati, and look at photographs, maps, and documents. We hope that this site helps you learn more about the lives of children in the Queen City.

##Installation

There are rake tasks for populating the site with admission records and images for the gallery.

###Images

`rake hor:import`

###Admission records

`rake gallery:import`

The admission records data is included in the vendor directory as [data.csv](http://github.com/jamesvanmil/house-of-refuge/blob/master/vendor/data.csv).

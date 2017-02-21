#Cincinnati House of Refuge Project

Welcome to the Cincinnati House of Refuge Project. This repository contains the source for a website featuring history, photographs, and searchable database of over 6,000 records of children admitted to the Cincinnati House of Refuge from 1869-1902.

Explore the database, read about the history of refuge in Cincinnati, and look at photographs, maps, and documents. We hope that this site helps you learn more about the lives of children in the Queen City of the West.

##Installation and technical

The site is built with Ruby on Rails and configured to store data in [PostgreSQL](https://www.postgresql.org/download/).

Clone the repository and `bundle install`

There are rake tasks for populating the site with admission records and images for the gallery.

###Images

`rake hor:import`

###Admission records

`rake gallery:import`

The admission records data is included in the vendor directory as [data.csv](http://github.com/jamesvanmil/house-of-refuge/blob/master/vendor/data.csv).

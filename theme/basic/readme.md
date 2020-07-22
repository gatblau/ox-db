# Basic Theme

This folder contains a basic theme that customise the look and feel of DbMan query results served over HTTP.

Whenever DbMan is run as an HTTP server, and a query is run, DbMan can fetch a theme in a repository and merge its 
contents with the return result web page.

The theme must be created as a folder with 3 files as follows:
- **style.css**: an optional style sheet which overrides the content of DbMan's initial stylesheet.
- **header.html**: an optional web page header.
- **footer.html**: an optional web page footer.
# Welcome to Iris
## Understand events through photos

Iris is a Startup Weekend App that consumes photos from multiple sources and digests it into timelines.

# Dev setup
`git clone https://github.com/vogelbek/iris.git`
`cd iris`
`bundle install`

# How to consume our data

## To see the activity over all known hotspots, try this URL
`http://guarded-beyond-2952.herokuapp.com/hotspots/2014-01-01/2014-03-25.json`

## To get photo URLs from a single hotspot for a daterange
`http://guarded-beyond-2952.herokuapp.com/hotspots/1/2014-01-01/2014-01-02.json`

The first date param is a start date, the second is the end

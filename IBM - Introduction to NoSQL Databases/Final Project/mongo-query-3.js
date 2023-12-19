// 10-mongo-query

db.movies.aggregate([
    {
        "$match": { "year": 2007 }
    },
    {
        "$group": {
            "_id": "$year",
            "avg_vote": { "$avg": "$Votes" }
        }
    }
])
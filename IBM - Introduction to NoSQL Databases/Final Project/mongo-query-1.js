// 8-mongo-query

db.movies.aggregate([
    {
        "$group": {
            "_id": "$year",
            "moviecount": { "$sum": 1 }
        }
    },
    { "$sort": { "moviecount": -1 } },
    { "$limit": 1 }
])
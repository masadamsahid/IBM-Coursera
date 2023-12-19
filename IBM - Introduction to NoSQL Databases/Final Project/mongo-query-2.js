// 9-mongo-query

db.movies.count({"year": {"$gt": 1999}})
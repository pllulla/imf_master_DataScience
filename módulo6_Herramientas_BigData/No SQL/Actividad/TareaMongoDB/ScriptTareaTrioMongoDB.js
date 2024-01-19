/* Pregunta 1. Mostrar el nombre y la población de las ciudades donde la población supera los 10000 habitantes */
db.cities.find(
    { pop: { $gte: 10000 }, "capital": { $exists: true } },
    {
        _id:0,
        city: 1,
        pop: 1
    }
).sort({ pop: -1 })

/* Pregunta 2. Mostrar el nombre y la población del estado según las ciudades mostradas anteriormente. */
db.cities.aggregate([
    {
        $match: {
            pop: { $gte: 10000 },
            capital: { $exists: true }
        }
    },
    {
        $lookup: {
            from: "cities",
            localField: "state",
            foreignField: "_id",
            as: "state"
        }
    },
    {
        $unwind: "$state"
    },
    {
        $project: {
            _id: 0,
            city: 1,
            pop: 1,
            state: {
                name: "$state.name",
                pop: "$state.pop"
            }
        }
    },
    {
        $sort: { pop: -1 }
    }
])

/* Pregunta 3. Muestra el _id, ciudad, nombre de la ciudad capital de cada estado con una población mayor a 20,000 habitantes. */
db.cities.aggregate([
    {
        $match: {
            pop: { $gte: 20000 }
        }
    },
    {
        $lookup: {
            from: "cities", 
            localField: "state",
            foreignField: "_id",
            as: "state"
        }
    },
    {
        $unwind: "$state"
    },
    {
        $project: {
            _id: 1,
            city: 1,
            "capital.name": 1,
            state: "$state.name"
        }
    }
])
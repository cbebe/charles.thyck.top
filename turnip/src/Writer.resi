type t = (array<Predictor.Prediction.t>, array<float>)
let showResults: t => unit
let parsePredictions: Predictor.t => t
let writeError: string => unit

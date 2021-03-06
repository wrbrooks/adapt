adaptive.weights <- function(x, y, family, weights, predictor.names, verbose=FALSE, ...) {
    #Create the object that will hold the output
    result <- list()

    #This is the amount of error to accept when declaring numbers equal:
    tol = .Machine$double.eps ^ 0.5

    #Get the OLS coefficient for each covariate
    coefs = list()
    for (predictor in predictor.names) {
        z = x[,predictor]

        if (!is.factor(z) && abs(max(z)-min(z)) < tol) {
            coefs[[predictor]] = 0
        }
            model = glm(y~z, family=family, weights=weights)
            coefs[[predictor]] = coef(model)[2]
        }
    #}

    result$coefs = coefs
    result$adaweight = sapply(predictor.names, function(x) abs(coefs[[x]]))

    return(result)
}

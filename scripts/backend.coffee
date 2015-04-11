_ = require('lodash')
$ = require('jquery')
data = require('./movies_data')

_returnAsync = (result) ->
  returning = $.Deferred()

  _.defer(() ->
    returning.resolve(result)
  )

  returning.promise()

module.exports = {
  addToFavourites: (movieId) ->
    favouriteMoviesOrder = JSON.parse(localStorage.getItem('favouriteMoviesIds'))

    movieToAdd = _.findWhere(data, {id: movieId})

    favouriteMoviesOrder.push(movieToAdd.id)
    localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @loadMovies(favouriteMoviesOrder)

  removeFromFavourites: (movieId) ->
    favouriteMoviesOrder = JSON.parse(localStorage.getItem('favouriteMoviesIds'))

    favouriteMoviesOrder = _.remove(favouriteMoviesOrder, movieId)

    localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @loadMovies(favouriteMoviesOrder)

  moveFavouriteMovieUp: (movieId) ->
    favouriteMoviesOrder = JSON.parse(localStorage.getItem('favouriteMoviesIds'))

    movieIndex = favouriteMoviesOrder.indexOf(movieId)
    if movieIndex > 0
      favouriteMoviesOrder = Array.prototype.concat(
        favouriteMoviesOrder.slice(0, movieIndex - 1), 
        [favouriteMoviesOrder[movieIndex], favouriteMoviesOrder[movieIndex - 1]], 
        favouriteMoviesOrder.slice(movieIndex + 1))

      localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @loadMovies(favouriteMoviesOrder)

  moveFavouriteMovieDown: (movieId) ->
    favouriteMoviesOrder = JSON.parse(localStorage.getItem('favouriteMoviesIds'))

    movieIndex = favouriteMoviesOrder.indexOf(movieId)
    if movieIndex >= 0 && movieIndex < favouriteMoviesOrder.length - 1
      favouriteMoviesOrder = Array.prototype.concat(
        favouriteMoviesOrder.slice(0, movieIndex), 
        [favouriteMoviesOrder[movieIndex + 1], favouriteMoviesOrder[movieIndex]], 
        favouriteMoviesOrder.slice(movieIndex + 2))

      localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @loadMovies(favouriteMoviesOrder)

  loadMovies: (favouriteMoviesOrder = JSON.parse(localStorage.getItem('favouriteMoviesIds'))) ->

    [favouriteMovies, otherMovies] = _.partition(data, (movie) ->
      movie.id in favouriteMoviesOrder
    )
    movies = _.reduce(data, ((memo, movie) ->
      movieIndex = favouriteMoviesOrder.indexOf(movie.id)
      if movieIndex >= 0
        memo.favourites[movieIndex] = movie
      else
        memo.other.push(movie)

      memo
    ), {favourites: [], other: []})

    movies.other = _.sortBy(otherMovies, 'title')

    _returnAsync(movies)
}
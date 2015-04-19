_ = require('lodash')
$ = require('jquery')
data = require('./movies_data')

_returnAsync = (result) ->
  returning = $.Deferred()

  _.defer(() ->
    returning.resolve(result)
  )

  returning.promise()

_getFavouriteMovies = () ->
  movies = JSON.parse(localStorage.getItem('favouriteMoviesIds')) || []
  movies

module.exports = {
  addToFavourites: (movieId) ->
    favouriteMoviesOrder = _getFavouriteMovies()

    movieToAdd = _.findWhere(data, {id: movieId})

    favouriteMoviesOrder.push(movieToAdd.id)
    localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @load(favouriteMoviesOrder)

  removeFromFavourites: (movieId) ->
    favouriteMoviesOrder = _getFavouriteMovies()

    favouriteMoviesOrder = _.filter(favouriteMoviesOrder, (mId) -> mId != movieId)

    localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @load(favouriteMoviesOrder)

  moveFavouriteUp: (movieId) ->
    favouriteMoviesOrder = _getFavouriteMovies()

    movieIndex = favouriteMoviesOrder.indexOf(movieId)
    if movieIndex > 0

      favouriteMoviesOrder = Array.prototype.concat(
        favouriteMoviesOrder.slice(0, movieIndex - 1), 
        [favouriteMoviesOrder[movieIndex], favouriteMoviesOrder[movieIndex - 1]], 
        favouriteMoviesOrder.slice(movieIndex + 1))

      localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @load(favouriteMoviesOrder)

  moveFavouriteDown: (movieId) ->
    favouriteMoviesOrder = _getFavouriteMovies()

    movieIndex = favouriteMoviesOrder.indexOf(movieId)
    if movieIndex >= 0 && movieIndex < favouriteMoviesOrder.length - 1

      favouriteMoviesOrder = Array.prototype.concat(
        favouriteMoviesOrder.slice(0, movieIndex), 
        [favouriteMoviesOrder[movieIndex + 1], favouriteMoviesOrder[movieIndex]], 
        favouriteMoviesOrder.slice(movieIndex + 2))

      localStorage.setItem('favouriteMoviesIds', JSON.stringify(favouriteMoviesOrder))

    @load(favouriteMoviesOrder)

  load: (favouriteMoviesOrder) ->

    favouriteMoviesOrder = favouriteMoviesOrder || _getFavouriteMovies()

    movies = _.reduce(data, ((memo, movie) ->
      movieIndex = favouriteMoviesOrder.indexOf(movie.id)
      if movieIndex >= 0
        memo.favourites[movieIndex] = movie
      else
        memo.other.push(movie)

      memo
    ), {favourites: [], other: []})

    movies.other = _.sortBy(movies.other, 'title')

    _returnAsync(movies)
}
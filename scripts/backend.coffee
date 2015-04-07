_ = require('lodash')
$ = require('jquery')

data = [
  {
    id: 0
    title: 'District 9'
  },
  {
    id: 1
    title: 'Ex Machina'
  },
  {
    id: 2
    title: 'Chappie'
  },
  {
    id: 3
    title: 'Bad Boys'
  },
  {
    id: 4
    title: '12 Angry Men'
  },
  {
    id: 5
    title: 'The Dark Knight'
  },
  {
    id: 6
    title: 'Fight Club'
  },
  {
    id: 7
    title: 'Life if Beautiful'
  },
  {
    id: 8
    title: 'City of God'
  }
]

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
    # favouriteMoviesOrder = JSON.parse(localStorage.getItem('favouriteMoviesIds'))

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
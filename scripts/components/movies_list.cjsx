$ = require('jquery')
React = require('react')
_ = require('lodash')
Backend = require('../backend')

module.exports = React.createClass
  getInitialState: () ->
    {
      movies: {}
    }

  componentDidMount: () ->
    @loadMovies()

  loadMovies: () ->
    Backend.loadMovies()
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  moveFavouriteMovieUp: (movieId) ->

    Backend.moveFavouriteMovieUp(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  moveFavouriteMovieDown: (movieId) ->
    Backend.moveFavouriteMovieDown(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  addToFavourites: (movieId) ->
    Backend.addToFavourites(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  removeFromFavourites: (movieId) ->
    Backend.removeFromFavourites(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  render: () ->
    favouriteMovies = null
    otherMovies = null

    unless _.isEmpty @state.movies
      if @state.movies.favourites.length
        favouriteMovies = @state.movies.favourites.map((movie) =>
          <div key={movie.id}>
            <button className='btn btn-default' onClick={_.partial(@removeFromFavourites, movie.id)}>
              <span className='glyphicon glyphicon-star'></span>
            </button>
            <span>{movie.title}, {movie.id}</span>
            <button className='btn btn-default' onClick={_.partial(@moveFavouriteMovieUp, movie.id)}>
              <span className='glyphicon glyphicon-arrow-up'></span>
            </button>
            <button className='btn btn-default' onClick={_.partial(@moveFavouriteMovieDown, movie.id)}>
              <span className='glyphicon glyphicon-arrow-down'></span>
            </button>
          </div>
        )

      if @state.movies.other.length
        otherMovies = @state.movies.other.map((movie) =>
          <div key={movie.id}>
            <button className='btn btn-default' onClick={_.partial(@addToFavourites, movie.id)}>
              <span className='glyphicon glyphicon-star-empty'></span>
            </button>
            <span>{movie.title}, {movie.id}</span>
          </div>
        )

    <div className='container'>
      <div className='row'>
        <div className='col-md-8 col-md-offset-2'>
          <div>
            <h1>Welcome to React Movielist</h1>
            <div>
              <h2>Favourite movies</h2>
              {favouriteMovies}
            </div>
            <div>
              <h2>Other movies</h2>
              {otherMovies}
            </div>
          </div>
        </div>
      </div>
    </div>


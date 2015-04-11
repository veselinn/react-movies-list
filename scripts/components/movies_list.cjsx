React = require('react')
_ = require('lodash')
Backend = require('../backend')
Movie = require('./movie')
FavouriteMovie = require('./favourite_movie')

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
          <div className='movie-tile' key={movie.id}>
            <FavouriteMovie
              movie={movie}
              removeFromFavourites={@removeFromFavourites}
              moveFavouriteUp={@moveFavouriteMovieUp}
              moveFavouriteDown={@moveFavouriteMovieDown}/>
          </div>
        )

      if @state.movies.other.length
        otherMovies = @state.movies.other.map((movie) =>
          <div className='movie-tile' key={movie.id}>
            <Movie 
              key={movie.id}
              movie={movie}
              addToFavourites={@addToFavourites}/>
          </div>
        )

    <div className='container'>
      <div className='row'>
        <div className='col-md-8 col-md-offset-2'>
          <div>
            <h1>React Movielist</h1>
            <div>
              <h2>Favourite movies</h2>
              <div>
                {favouriteMovies}
              </div>
            </div>
            <div>
              <h2>Other movies</h2>
              <div>
                {otherMovies}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


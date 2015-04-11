React = require('react')
_ = require('lodash')
MoviesBackend = require('../movies_backend')
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
    MoviesBackend.load()
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  moveFavouriteMovieUp: (movieId) ->
    MoviesBackend.moveFavouriteUp(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  moveFavouriteMovieDown: (movieId) ->
    MoviesBackend.moveFavouriteDown(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  addToFavourites: (movieId) ->
    MoviesBackend.addToFavourites(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  removeFromFavourites: (movieId) ->
    MoviesBackend.removeFromFavourites(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  render: () ->
    favouriteMovies = <div>No favourites yet.</div>
    otherMovies = <div>Sad story. No movies.</div>

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


$ = require('jquery')
React = require('react')
_ = require('lodash')
Backend = require('../backend')

module.exports = React.createClass
  getInitialState: () ->
    {
      loadingMovies: true
      movies: {}
    }

  componentDidMount: () ->
    @loadMovies()

  loadMovies: () ->
    Backend.loadMovies()
    .done((movies) =>
      @setState({
        loadingMovies: false
        movies: movies
      })
    )

  moveFavouriteMovieUp: (movieId) ->
    @setState({
      loadingMovies: false
    })
    Backend.moveFavouriteMovieUp(movieId)
    .done((movies) =>
      @setState({
        movies: movies
      })
    )

  moveFavouriteMovieDown: (movieId) ->
    @setState({
      loadingMovies: false
    })
    Backend.moveFavouriteMovieDown(movieId)
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
        otherMovies = @state.movies.other.map((movie) ->
          <div key={movie.id}>{movie.title}, {movie.id}</div>
        )

    content = if @state.loadingMovies
      <h1>Loading movies...</h1> 
    else
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

    <div className='container'>
      <div className='row'>
        <div className='col-md-8 col-md-offset-2'>
          {content}
        </div>
      </div>
    </div>


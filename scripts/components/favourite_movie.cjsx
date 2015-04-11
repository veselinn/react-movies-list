React = require('react')
_ = require('lodash')
MovieInfo = require('./movie_info')

module.exports = React.createClass
  getDefaultsProps: () ->
    {
      removeFromFavourites: _.noop
      moveFavouriteUp: _.noop
      moveFavouriteDown: _.noop
    }

  handleRemoveFromFavourites: () ->
    @props.removeFromFavourites(@props.movie.id)

  handleMoveFavouriteUp: () ->
    @props.moveFavouriteUp(@props.movie.id)

  handleMoveFavouriteDown: () ->
    @props.moveFavouriteDown(@props.movie.id)

  render: () ->
    <div>
      <div className="btn-group" role="group">
        <button type="button" className='btn btn-default' onClick={@handleRemoveFromFavourites}>
          <span className='glyphicon glyphicon-star'></span>
        </button>
        <button type="button" className='btn btn-default' onClick={@handleMoveFavouriteUp}>
          <span className='glyphicon glyphicon-arrow-up'></span>
        </button>
        <button type="button" className='btn btn-default' onClick={@handleMoveFavouriteDown}>
          <span className='glyphicon glyphicon-arrow-down'></span>
        </button>
      </div>
      <MovieInfo movie={@props.movie}/>
    </div>
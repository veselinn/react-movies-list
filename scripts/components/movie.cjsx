React = require('react')
_ = require('lodash')
MovieInfo = require('./movie_info')

module.exports = React.createClass
  getDefaultsProps: () ->
    {
      addToFavourites: _.noop
    }

  handleAddToFavourites: () ->
    @props.addToFavourites(@props.movie.id)

  render: () ->
    <div>
      <button className='btn btn-default' onClick={@handleAddToFavourites}>
        <span className='glyphicon glyphicon-star-empty'></span>
      </button>
      <MovieInfo movie={@props.movie}/>
    </div>
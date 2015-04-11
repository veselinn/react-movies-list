React = require('react')
_ = require('lodash')

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
      <span>{@props.movie.title}, {@props.movie.id}</span>
    </div>
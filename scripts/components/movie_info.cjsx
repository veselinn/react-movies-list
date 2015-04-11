React = require('react')
_ = require('lodash')

module.exports = React.createClass
  getInitialState: () ->
    {
      extended: false
    }

  toggleExtended: () ->
    @setState({
      extended: !@state.extended  
    })

  render: () ->
    shortInfo = <div>
      <span>{@props.movie.title} ({@props.movie.year})</span>
    </div>

    content = if @state.extended
      <div>
        {shortInfo}
        <div>
          <div>Director: {@props.movie.director}</div>
          <div>Description: {@props.movie.description}</div>
        </div>
      </div>
    else
      shortInfo

    <div className='movie-info' onClick={@toggleExtended}>
      {content}
    </div>
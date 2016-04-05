React = require 'react'

MultiInput = require './multi-input'

LoTags = React.createClass

  propTypes:
    exerciseId: React.PropTypes.string.isRequired

  validateInput: (value) ->
    'Must match CNX feature' unless value.match(
      /^\d+-\d+-\d+$/
    )

  cleanInput: (val) ->
    val.replace(/[^0-9\-]/g, '')

  render: ->
    <MultiInput
      {...@props}
      label='LO'
      prefix='lo'
      placeholder='nn-nn-nn'
      cleanInput={@cleanInput}
      validateInput={@validateInput}
    />

module.exports = LoTags

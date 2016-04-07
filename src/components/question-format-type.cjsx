React = require 'react'
BS = require 'react-bootstrap'
_ = require 'underscore'

{QuestionActions, QuestionStore} = require '../stores/question'


PREFIX = 'format'
TYPES =
  'multiple-choice' : 'Multiple Choice'
  'true-false'      : 'True/False'
  'vocabulary'      : 'Vocabulary'
  'open-ended'      : 'Open Ended'

QuestionFormatType = React.createClass


  update: -> @forceUpdate()

  componentWillMount: ->
    QuestionStore.addChangeListener(@update)

  componentWillUnmount: ->
    QuestionStore.removeChangeListener(@update)

  propTypes:
    questionId: React.PropTypes.number.isRequired

  updateFormat: (ev) ->
    formats =  QuestionStore.get(@props.questionId).formats
    if ev.target.checked
      formats.push(ev.target.name)
    else
      formats = _.without(formats, ev.target.name)
    QuestionActions.setFormats(@props.questionId, formats)

  setChoiceRequired: (ev) ->
    QuestionActions.setChoiceRequired(@props.questionId, ev.target.checked)

  isFormatDisabled: (id, required) ->
    id is 'free-response' and required

  render: ->
    formats =  QuestionStore.get(@props.questionId).formats
    isChoiceRequired = QuestionStore.isChoiceRequired(@props.questionId)

    <div className="format-type">
      {for id, name of TYPES
        <BS.Input key={id} name={id} type="checkbox" label={name}
          disabled={@isFormatDisabled(id, isChoiceRequired)}
          checked={_.contains(formats, id)}
          onChange={@updateFormat} />}

      <BS.Input type="checkbox" label="Requires Choices"
        onChange={@setChoiceRequired}
        checked={isChoiceRequired} />
    </div>


module.exports = QuestionFormatType
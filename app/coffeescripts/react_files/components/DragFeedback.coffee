define [
  'react'
  './FilesystemObjectThumbnail'
  '../modules/customPropTypes'
  'compiled/react/shared/utils/withReactElement'
], (React, FilesystemObjectThumbnailComponent, customPropTypes, withReactElement) ->

  MAX_THUMBNAILS_TO_SHOW = 10
  FilesystemObjectThumbnail = React.createFactory FilesystemObjectThumbnailComponent

  DragFeedback = React.createClass
    displayName: 'DragFeedback'

    propTypes:
      itemsToDrag: React.PropTypes.arrayOf(customPropTypes.filesystemObject).isRequired
      pageX: React.PropTypes.number.isRequired
      pageY: React.PropTypes.number.isRequired

    render:  withReactElement ->
      div {
        className: 'DragFeedback'
        style:
          # this'll cause less jank than setting css 'top' and 'left'
          webkitTransform: "translate3d(#{@props.pageX + 6}px, #{@props.pageY+ 6}px, 0)"
          transform: "translate3d(#{@props.pageX + 6}px, #{@props.pageY+ 6}px, 0)"
      },
        @props.itemsToDrag.slice(0, MAX_THUMBNAILS_TO_SHOW).map (model, index) =>
          FilesystemObjectThumbnail
            model: model
            key: model.id
            style:
              left: 10 + index * 5 - index
              top: 10 + index * 5 - index
        span className: 'badge badge-important',
          @props.itemsToDrag.length

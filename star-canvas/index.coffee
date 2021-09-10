inputCanvas = document.getElementById("input")
inputContext = inputCanvas.getContext("2d")
indicatorCanvas = document.getElementById("indicator")
indicatorContext = indicatorCanvas.getContext("2d")
paths = []

inputCanvas.addEventListener 'click', (e) ->
  bound = inputCanvas.getBoundingClientRect()
  x = e.pageX - bound.left
  y = e.pageY - bound.top
  color = 'white'
  color = starInfo.color for starInfo in paths when (
    inputContext.isPointInPath starInfo.star, x, y
  )
  fillIndicator color

fillIndicator = (color) ->
  indicatorContext.fillStyle = color
  indicatorContext.fillRect 0, 0, indicatorCanvas.width, indicatorCanvas.height

drawStar = (centerX, centerY, color = 'black') ->
  rotation = (Math.PI / 2) * 3
  x = centerX
  y = centerY
  spikes = 5
  outerRadius = 60
  innerRadius = 30
  step = Math.PI / spikes

  star = new Path2D
  star.moveTo centerX, centerY - outerRadius

  drawAngle = ->
    x = centerX + Math.cos(rotation) * outerRadius
    y = centerY + Math.sin(rotation) * outerRadius
    star.lineTo(x, y)
    rotation += step

    x = centerX + Math.cos(rotation) * innerRadius
    y = centerY + Math.sin(rotation) * innerRadius
    star.lineTo x, y
    rotation += step

  drawAngle() for x in [0...spikes]
  star.lineTo centerX, centerY - outerRadius
  star.closePath()
  inputContext.fillStyle = color
  inputContext.fill star
  { star, color }

paths.push drawStar 100, 100, 'red'
paths.push drawStar 500, 100, 'blue'
paths.push drawStar 300, 300, 'green'
paths.push drawStar 100, 500, 'yellow'
paths.push drawStar 500, 500
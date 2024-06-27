 sub init()
      ? "content"
      m.content_grid = m.top.findNode("ContentPosterGrid")
      m.setContent = createObject("roSGNode", "SetContent")
      m.top.observeField("visible", "onVisibleChange")
      m.top.backgroundcolor="662D91"
      m.top.backgroundUri=""
 end sub

sub onVisibleChange()
  ? "visibleChange"
  if m.top.visible = true then
    ? m.top.contenturi
    m.setContent.contenturi = m.top.contenturi
    m.setContent.observeField("content", "showPosterGrid")
    m.setContent.control = "RUN"
  end if
end sub

sub showPosterGrid()
    ? "showPosterGrid"
    ? m.setContent.content
    m.content_grid.content = m.setContent.content
    m.content_grid.visible = true
    m.content_grid.setFocus(true)
    ? m.content_grid.visible 
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  if m.top.visible = true then
    onVisibleChange()
  end if
  return true
end function
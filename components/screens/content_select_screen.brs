 sub init()
      '? "content"
      'm.top.backgroundUri=""
      'm.top.backgroundColor="0x662D91"
      m.content_grid = m.top.findNode("ContentPosterGrid")
      m.setContent = createObject("roSGNode", "SetContent")
      m.top.observeField("visible", "onVisibleChange")
 end sub

sub onVisibleChange()
  '? "visibleChange"
  if m.top.visible = true then
    ? m.top.contenturi
    m.setContent.contenturi = m.top.contenturi
    m.setContent.control = "RUN"
    m.setContent.observeField("content", "showPosterGrid")
  end if
end sub

sub OnContentChange(obj)
	item = obj.getData()
	'? item
  'm.hdgridposterurl1.contenturi = "http://192.168.43.99:8080/" + item + "/1.png"
  'm.hdgridposterurl2.contenturi = "http://192.168.43.99:8080/" + item + "/2.png"
  'm.hdgridposterurl3.contenturi = "http://192.168.43.99:8080/" + item + "/3.png"
  'm.hdgridposterurl4.contenturi = "http://192.168.43.99:8080/" + item + "/4.png"
  'm.hdgridposterurl5.contenturi = "http://192.168.43.99:8080/" + item + "/5.png"
  'm.hdgridposterurl6.contenturi = "http://192.168.43.99:8080/" + item + "/6.png"
 ' m.hdgridposterurl7.contenturi = "http://192.168.43.99:8080/" + item + "/7.png"
  'm.hdgridposterurl8.contenturi = "http://192.168.43.99:8080/" + item + "/8.png"
  'm.hdgridposterurl9.contenturi = "http://192.168.43.99:8080/" + item + "/9.png"
  '? m.hdgridposterurl1.contenturi

end sub

sub showPosterGrid()
    ? "showPosterGrid"
    m.content_grid.visible = true
    m.content_grid.setFocus(true)
end sub


sub init()
	m.title = m.top.FindNode("title")
	m.description = m.top.FindNode("description")
	m.thumbnail = m.top.FindNode("thumbnail")
	m.play_button = m.top.FindNode("play_button")
	m.buy_button = m.top.FindNode("buy_button")
	m.top.observeField("visible", "onVisibleChange")
	m.play_button.setFocus(true)
end sub

sub onVisibleChange()
	if m.top.visible = true then
		m.play_button.setFocus(true)
	end if
end sub

sub OnContentChange(obj)
	item = obj.getData()
	? item
	m.title.text = item.shortdescriptionline1
	m.description.text = item.shortdescriptionline2
	m.thumbnail.uri = item.HDGRIDPOSTERURL
end sub
 
function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press
	if press then
		if key = "up" or key = "down"
			if m.play_button.hasFocus()
				m.buy_button.setFocus(true)
			else
				m.play_button.setFocus(true)
			end if
		end if
	end if
  return false
end function
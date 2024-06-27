function init()
	? "[home_scene] init"
	m.category_select_screen = m.top.findNode("category_select_screen")
	m.content_select_screen = m.top.findNode("content_select_screen")
	m.details_screen = m.top.findNode("details_screen")
	m.videoplayer = m.top.findNode("videoplayer")
	m.error_dialog = m.top.findNode("error_dialog")
	m.scan_poster = m.top.findNode("scan_poster")
	initializeVideoPlayer()

	m.content_select_screen.observeField("content_selected", "onContentSelected")
	m.category_select_screen.observeField("category_selected", "onCategorySelected") 
	m.details_screen.observeField("play_button_pressed", "onPlayButtonPressed")
	m.details_screen.observeField("buy_button_pressed", "onBuyButtonPressed")
	m.category_select_screen.visible = true
	m.category_select_screen.setFocus(true)
end function

sub initializeVideoPlayer()
	m.videoplayer.EnableCookies()
	m.videoplayer.setCertificatesFile("common:/certs/ca-bundle.crt")
	m.videoplayer.InitClientCertificates()
	'set position notification to 1 second
	m.videoplayer.notificationInterval=1
	m.videoplayer.observeFieldScoped("position", "onPlayerPositionChanged")
	m.videoplayer.observeFieldScoped("state", "onPlayerStateChanged")
end sub

sub onCategorySelected(obj)
	m.category_select_screen.visible = false
	m.top.backgroundUri=""
	m.top.backgroundColor="0x662D91"
	m.content_select_screen.visible = true
	m.content_select_screen.setFocus(true)
end sub

sub onContentSelected(obj)
	selected_index = obj.getData()
	? "content selected_index :";selected_index
	m.details_screen.content = m.content_select_screen.findNode("ContentPosterGrid").content.getChild(selected_index)
	m.content_select_screen.visible = false
	m.details_screen.visible = true
end sub

sub onPlayButtonPressed(obj)
	m.details_screen.visible = false
	m.videoplayer.visible = true
	m.videoplayer.setFocus(true)
	m.videoplayer.content = m.details_screen.content
	m.videoplayer.control = "play"
end sub

sub onBuyButtonPressed(obj)
	m.details_screen.visible = false
	m.scan_poster.visible = true
	m.scan_poster.setFocus(true)
	? "scan_poster"
end sub


sub onPlayerStateChanged(obj)
    state = obj.getData()
	? "onPlayerStateChanged: ";state
	if state="error"
    	showErrorDialog(m.videoplayer.errorMsg+ chr(10) + "Error Code: "+m.videoplayer.errorCode.toStr())
	else if state = "finished"
		closeVideo()
	end if
end sub

sub closeVideo()
	m.videoplayer.control = "stop"
	m.videoplayer.visible=false
	m.details_screen.visible=true
end sub

sub showErrorDialog(message)
	m.error_dialog.title = "ERROR"
	m.error_dialog.message = message
	m.error_dialog.visible=true
	m.top.dialog = m.error_dialog
end sub

function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press
	' we must capture the 'true' for press, it comes first (true=down,false=up) to keep the firmware from handling the event
	if key = "back" and press
		if m.content_select_screen.visible
			m.content_select_screen.visible=false
			m.category_select_screen.visible=true
			m.category_select_screen.setFocus(true)
			return true
		else if m.details_screen.visible
			m.details_screen.visible=false
			m.content_select_screen.visible=true
			m.content_select_screen.setFocus(true)
			return true
		else if m.videoplayer.visible
			m.videoplayer.visible=false
			m.details_screen.visible=true
			m.details_screen.setFocus(true)
			return true
		end if
	end if
  return false
end function
function popup_meter(url) {
        newwindow = window.open(url, 'name', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=300,height=300');
	if (window.focus) {newwindow.focus()}
	return false;
}

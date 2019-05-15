var pushRight = slate.operation("push", {
  "direction": "right",
  "style": "bar-resize:screenSizeX/2"
});

var pushLeft = slate.operation("push", {
  "direction": "left",
  "style": "bar-resize:screenSizeX/2"
});

var throwNextLeft = slate.operation("throw", {
  "width": "screenSizeX/2",
  "height": "screenSizeY",
  "screen": "next"
});

var throwNextRight = slate.operation("throw", {
  "x": "screenOriginX+(screenSizeX)/2",
  "y": "screenOriginY",
  "width": "screenSizeX/2",
  "height": "screenSizeY",
  "screen": "next"
});

var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});

var throwNextFullscreen = slate.operation("throw", {
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width": "screenSizeX",
  "height": "screenSizeY",
  "screen": "next"
});

var throwNextTop = slate.operation("throw", {
  "x": "screenOriginX",
  "y": "screenOriginY",
  "width": "screenSizeX",
  "height": "screenSizeY/2",
  "screen": "next"
});

var throwNextBottom = slate.operation("throw", {
  "x": "screenOriginX",
  "y": "screenOriginY + screenSizeY / 2",
  "width": "screenSizeX",
  "height": "screenSizeY/2",
  "screen": "next"
});


var throwNext = function(win) {
  if (!win) {
    return;
  }
  var winRect = win.rect();
  var screen = win.screen().visibleRect();

  var newX = (winRect.x - screen.x)/screen.width+"*screenSizeX+screenOriginX";
  var newY = (winRect.y - screen.y)/screen.height+"*screenSizeY+screenOriginY";
  var newWidth = winRect.width/screen.width+"*screenSizeX";
  var newHeight = winRect.height/screen.height+"*screenSizeY";
  var throwNext = slate.operation("throw", {
    "x": newX,
    "y": newY,
    "width": newWidth,
    "height": newHeight,
    "screen": "next"
  });
  win.doOperation(throwNext);
};

var pushedLeft = function(win) {
  if (!win) {
    return false;
  }
  var winRect = win.rect();
  var screen = win.screen().visibleRect();

  if (winRect.x === screen.x &&
      winRect.y === screen.y &&
      winRect.width === screen.width/2 &&
      winRect.height === screen.height
    ) {
    return true;
  }
  return false;
};

var pushedRight = function(win) {
  if (!win) {
    return false;
  }
  var winRect = win.rect();
  var screen = win.screen().visibleRect();

  if (winRect.x === screen.x + screen.width/2 &&
      winRect.y === screen.y &&
      winRect.width === screen.width/2 &&
      winRect.height === screen.height
    ) {
    return true;
  }
  return false;
};

var isFullscreen = function(win) {
  if (!win) {
    return false;
  }
  var winRect = win.rect();
  var screen = win.screen().visibleRect();
  if (winRect.width === screen.width &&
      winRect.height === screen.height
    ) {
    return true;
  }
  return false;
}

slate.bind("m:alt,cmd", function(win) {
  if (!win) {
    return;
  }
  win.doOperation(fullscreen);
});


slate.bind("left:alt,cmd", function(win) {
  if (!win) {
    return;
  }
  if (pushedLeft(win)) {
    win.doOperation(throwNextLeft);
  } else {
    win.doOperation(pushLeft);
  }
});

slate.bind("right:alt,cmd", function(win) {
  if (!win) {
    return;
  }

  if (pushedRight(win)) {
    win.doOperation(throwNextRight);
  } else {
    win.doOperation(pushRight);
  }
});

slate.bind("up:alt,cmd", function(win) {
  if (!win) {
    return;
  }

  win.doOperation(throwNextTop);
});

slate.bind("down:alt,cmd", function(win) {
  if (!win) {
    return;
  }

  win.doOperation(throwNextBottom);
});


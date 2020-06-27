chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('window.html', {
      'outerBounds': {
          'width': 100,
          'height': 100
      }
  })
  chrome.sockets.tcp.create(null, (createInfo => {
    chrome.sockets.tcp.connect(createInfo.socketId, 'localhost',8931, (result => {
          if(result < 0) {
            console.error("Failed to connect to socket!")
          } else {
            const enc = new TextEncoder();
            function getBatteryStatus() {
              navigator.getBattery().then(battery => {
                chrome.sockets.tcp.send(createInfo.socketId, enc.encode([battery.level, battery.charging]),
                    (result, bytes) => {})
              });
            }

            chrome.alarms.create('batteryLevel', {
              when: Date.now() + 500,
              periodInMinutes: 1
            });
            chrome.runtime.onInstalled.addListener(getBatteryStatus);
            chrome.alarms.onAlarm.addListener(getBatteryStatus);
          }
        }
    ))
  }))
});

chrome.runtime.onSuspend.addListener(function() {
    console.log("Suspending")
})

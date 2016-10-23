'use strict';

var page = require('webpage').create();

page.open('http://www.cimbbank.com.my/en/personal/support/locate-us.html', function(status) {
  var str = page.evaluate(function() {
    return atmMarkerListString + branchMarkerListString;
  });

  console.log('###' + str);
  phantom.exit();
});

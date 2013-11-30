$(document).ready(function() {
  $.ajax({
    url: '/tweetstream',
    type: 'get'
  })

  console.log("escaped AJAX")

  setInterval(getNewCoffeeCount, 500)

  function getNewCoffeeCount() {
    $.ajax({
      url: '/coffee-count',
      type: 'get'
    }).done(function(data) {
      console.log(data)
    })
  }
});

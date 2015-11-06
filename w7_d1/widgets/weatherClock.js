var Time = React.createClass({
  getInitialState: function() {
    return ({date: new Date()});
  },

  componentDidMount: function() {
    this.intervalId = setInterval(this.updateTime, 1000);
  },

  updateTime: function() {
    this.setState({date: new Date()});
  },

  componentWillUnmount: function() {
    clearInterval(this.intervalId);
  },

  render: function() {
    return(
      <div>
        {this.state.date.toString()}
      </div>
    );
  }
});

var Weather = React.createClass({
  getInitialState: function() {
    return ({ weather: null });
  },

  componentDidMount: function() {
    navigator.geolocation.getCurrentPosition(function(result){
      var lat = result.coords.latitude.toFixed(2);
      var long = result.coords.longitude.toFixed(2);
      this.handleLocation(lat,long);
    }.bind(this));
  },

  handleLocation: function (lat, long) {
    var request = new XMLHttpRequest();
    var url = "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + long;
    request.open('GET', url, true);

    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
      // Success!
      var resp = request.responseText;
      var weatherObj = JSON.parse(resp);
      this.setState({weather: weatherObj.main.temp});
      // JSON.parse()
      } else {
      // We reached our target server, but it returned an error
      this.setState({weather: "COULD NOT RETURN WEATHER!"});
      }
    }.bind(this);

    request.onerror = function() {
    // There was a connection error of some sort
      alert("ERROR!");
    };

    request.send();

  },

  render: function() {
    return(
      <div>
        {this.state.weather}
      </div>
    );
  }
});

var WeatherClock = React.createClass({
  render: function() {
    return(
      <div>
        <Time/>
        <Weather/>
      </div>
    );
  }
});

React.render(<WeatherClock/>, document.getElementById('weather-clock'));

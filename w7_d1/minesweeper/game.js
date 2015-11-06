var React = window.React;

var Tile = React.createClass({

  handleClick: function(event) {
    console.log("clicked");
    var pos = this.props.pos;
    var bool = event.altKey;
    this.props.updateFunc(pos, bool);
  },

  render: function(){
    var displayText;
    var tile = this.props.object;
    if (tile.flagged) {
      displayText = "F";
    } else if (tile.bombed && tile.explored) {
      displayText = "B";
    } else if (tile.explored) {
      displayText = tile.adjacentBombCount();
    } else {
      displayText = "T";
    }
    return(<div key={this.props.key}
                onClick={this.handleClick}
                className="cell">{displayText}</div>);
  }
});

var Board = React.createClass({
  render: function(){
    return(
      <div className="container">
        {
          this.props.boardState.grid.map(function(row, rIdx) {
            return (
              <div className="row">
                {
                  row.map(function(tile, tIdx) {
                    return (<Tile
                      object={tile}
                      pos={[rIdx, tIdx]}
                      updateFunc={this.props.updateFunc}
                      key={[rIdx, tIdx]}
                      />);
                  }.bind(this))
                }
              </div>
            );
          }.bind(this))
        }
      </div>
    );
  }
});

var Game = React.createClass({
  getInitialState: function(){
    return({
      board: new window.Minesweeper.Board(20, 5),
      gameOver: false,
      gameWon: false
    });
  },

  updateGame: function(pos, bool){
    if (bool) {
      this.state.board.grid[pos[0]][pos[1]].toggleFlag();
    } else {
      this.state.board.grid[pos[0]][pos[1]].explore();
    }
    this.setState({gameOver: this.state.board.lost(), gameWon: this.state.board.won()});
  },

  render: function(){
    return(
      <div>
        <Board
          boardState={ this.state.board }
          updateFunc={ this.updateGame }/>
      </div>
    );
  }
});

React.render(<Game/>, document.getElementById('game'));

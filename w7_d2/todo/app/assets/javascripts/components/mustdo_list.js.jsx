var React = window.React;
var MustdoStore = window.MustdoStore;

var MustdoList = React.createClass({
  getInitialState: function() {
    return {store: MustdoStore.all()};
  },
  mustdosChanged: function() {
    this.setState({ store: MustdoStore.all() });
  },
  componentDidMount: function() {
    MustdoStore.addChangedHandler(this.mustdosChanged);
    MustdoStore.fetch();
  },
  componentWillUnmount: function() {
    MustdoStore.removeChangedHandler(this.mustdosChanged);
  },
  render: function() {
    return(
      <div>
        <ul>
          <MustDoListForm/>
        </ul>
        <ul>
          {
            this.state.store.map(function(el){
              return <MustdoListItem key={el} list={el}/>;
          })
        }
        </ul>
      </div>
    );
  }
});

var MustdoListItem = React.createClass({
  getInitialState: function() {
    return {};
  },
  create: function(){

  },
  render: function() {
    return (
      <div>
        <ul>
          {this.props.list.title}
          <li>
            {this.props.list.body}
          </li>
        </ul>
      </div>
    );
  }
});

var MustDoListForm = React.createClass({
  getInitialState: function() {
    return ({ title: "", body: "", done: false});
  },
  updateTitle: function(e){
    this.setState( {title: e.target.value} );
  },
  updateBody: function(e){
    this.setState( {body: e.target.value} );
  },
  formSubmitted: function(e) {
    e.preventDefault();
    MustdoStore.create({mustdo: this.state});
    this.setState({title:"", body:""});
  },
  render: function() {
    return (
      <form onSubmit={this.formSubmitted}>
        Title
        <input type="text" onChange={this.updateTitle} value={this.state.title}/>
        Body
        <input type="text" onChange={this.updateBody} value={this.state.body}/>
        <input type="submit" value="create list item!"/>
      </form>
    );
  }
});

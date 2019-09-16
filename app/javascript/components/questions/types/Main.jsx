var React = require("react");

class Main extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="column is-12">
        <div className="field">
          <label className="label">Single Choice</label>
          <div className="buttons are-small">
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1)}
            >
              List Radio
            </a>
            <a className="button is-primary is-rounded">List Dropdown</a>
            <a className="button is-primary is-rounded">List with comment</a>
            <a className="button is-primary is-rounded">5 point choice</a>
          </div>
        </div>
        <div className="field">
          <label className="label">Multiple Choice</label>
          <div className="buttons are-small">
            <a className="button is-primary is-rounded">Multiple Choice</a>
            <a className="button is-primary is-rounded">
              Multiple Choice with comments
            </a>
          </div>
        </div>
        <div className="field">
          <label className="label">Open Ended</label>
          <div className="buttons are-small">
            <a className="button is-primary is-rounded">Textarea</a>
            <a className="button is-primary is-rounded">Multiple input text</a>
          </div>
        </div>
      </div>
    );
  }
}

export default Main;

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
              onClick={() => this.props.handler(1, "List (Radio)")}
            >
              List Radio
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "List (Dropdown)")}
            >
              List Dropdown
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "List With Comment")}
            >
              List with comment
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "5 point")}
            >
              5 point choice
            </a>
          </div>
        </div>
        <div className="field">
          <label className="label">Multiple Choice</label>
          <div className="buttons are-small">
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Multiple Choice")}
            >
              Multiple Choice
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() =>
                this.props.handler(
                  1,
                  "Multiple Choice with comments Questionaire"
                )
              }
            >
              Multiple Choice with comments
            </a>
          </div>
        </div>
        <div className="field">
          <label className="label">Open Ended</label>
          <div className="buttons are-small">
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(2, "Textarea")}
            >
              Textarea
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Multiple input text")}
            >
              Multiple input text
            </a>
          </div>
        </div>
      </div>
    );
  }
}

export default Main;

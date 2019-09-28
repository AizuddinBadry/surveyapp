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
              onClick={() => this.props.handler(1, "List (Radio) Questionaire")}
            >
              List Radio
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() =>
                this.props.handler(1, "List (Dropdown) Questionaire")
              }
            >
              List Dropdown
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() =>
                this.props.handler(1, "List With Comment Questionaire")
              }
            >
              List with comment
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "5 point Questionaire")}
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
              onClick={() =>
                this.props.handler(1, "Multiple Choice Questionaire")
              }
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
              onClick={() => this.props.handler(2, "Textarea Questionaire")}
            >
              Textarea
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() =>
                this.props.handler(1, "Multiple input text Questionaire")
              }
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

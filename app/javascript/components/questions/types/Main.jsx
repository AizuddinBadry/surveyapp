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
              onClick={() => this.props.handler(1, "Radio Button")}
            >
              Radio Button
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Select Dropdown")}
            >
              Select Dropdown
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Radio Button With Comment")}
            >
              Radio Button With Comment
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Radio Button Level")}
            >
              Radio Button Level
            </a>          
          </div>
        </div>
        <div className="field">
          <label className="label">Multiple Choice</label>
          <div className="buttons are-small">
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Checkbox")}
            >
              Checkbox
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Checkbox With Comment")}
            >
              Checkbox With Comment
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() =>
                this.props.handler(
                  1,
                  "Checkbox With Limit"
                )
              }
            >
              Checkbox with Limit
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() =>
                this.props.handler(
                  1,
                  "Checkbox With Text"
                )
              }
            >
              Checkbox With Text
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
              onClick={() => this.props.handler(2, "Textbox")}
            >
              Textbox
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Multiple Textbox")}
            >
              Multiple Textbox
            </a>
          </div>
        </div>
        <div className="field">
          <label className="label">Mask</label>
          <div className="buttons are-small">
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Ranking")}
            >
              Ranking
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(2, "Numerical")}
            >
              Numerical
            </a>
          </div>
        </div>
        <div className="field">
          <label className="label">Arrays</label>
          <div className="buttons are-small">
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Array")}
            >
              Array
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Array Numerical")}
            >
              Array Numerical
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Array Multiple answer")}
            >
              Array Multiple answer
            </a>
            <a
              className="button is-primary is-rounded"
              onClick={() => this.props.handler(1, "Array Dropdown")}
            >
              Array Dropdown
            </a>
          </div>
        </div>
      </div>
    );
  }
}

export default Main;

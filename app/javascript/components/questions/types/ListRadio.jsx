var React = require("react");
import Trumbowyg from "react-trumbowyg";
class ListRadio extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <div className="column is-12">
        <div class="field">
          <a
            className="button is-black is-small"
            onClick={() => this.props.handler(0)}
          >
            Back to options
          </a>
        </div>
        <div class="content">
          <div class="field">
            <label class="label">Description</label>
            <Trumbowyg id="question-description" />
          </div>
          <div className="field">
            <label className="label">This question is mandatory?</label>
            <input type="checkbox" id="switch"></input>
            <label class="toggle" for="switch"></label>
          </div>
          <div className="field">
            <label className="label">Answer Options</label>
          </div>
        </div>
      </div>
    );
  }
}

export default ListRadio;
